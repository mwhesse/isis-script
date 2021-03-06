/*******************************************************************************
 * Copyright (c) 2015 Torsten Juergeleit.
 * 
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution.
 * 
 * The Eclipse Public License is available at
 *    http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at
 *    http://www.eclipse.org/org/documents/edl-v10.html.
 * 
 * Contributors:
 *     Torsten Juergeleit - initial API and implementation
 *******************************************************************************/
package org.vaulttec.isis.script.tests

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Test
import org.junit.runner.RunWith
import org.vaulttec.isis.script.dsl.IsisBehaviour
import org.vaulttec.isis.script.dsl.IsisEntity
import org.vaulttec.isis.script.dsl.IsisFile
import org.vaulttec.isis.script.dsl.IsisPropertyFeatureType
import org.vaulttec.isis.script.dsl.IsisService

import static org.junit.Assert.*

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(IsisInjectorProvider))
class IsisParsingTest {

	@Inject extension ParseHelper<IsisFile>
	@Inject extension ValidationTestHelper

	@Test
	def void parseEntity() {
		'''
			package org.vaulttec.isis.script.test
			entity Entity1 {
				inject Object injection1
				property int prop1 {
					default {
						-1
					}
					event Event1
				}
				property String prop2 {
					derived {
						"result"
					}
				}
				collection java.util.Set<String> collection1 = new java.util.TreeSet<String> {
					event Event2
				}
				action String action1 {
					body {
						""
					}
					event Event3
				}
			}
		'''.parse => [
			assertNoErrors
			assertEquals("org.vaulttec.isis.script.test", package.name)
			val entity = declaration as IsisEntity
			assertEquals("Entity1", entity.name)
			assertEquals("injection1", entity.injections.get(0).name)
			
			assertEquals("prop1", entity.properties.get(0).name)
			assertEquals("Event1", entity.properties.get(0).events.get(0).name)

			assertEquals("prop2", entity.properties.get(1).name)
			assertEquals(1, entity.properties.get(1).features.size)
			assertEquals(IsisPropertyFeatureType.DERIVED, entity.properties.get(1).features.get(0).type)
			
			assertEquals("collection1", entity.collections.get(0).name)
			assertEquals("Event2", entity.collections.get(0).events.get(0).name)
			
			assertEquals("action1", entity.actions.get(0).name)
			assertEquals("Event3", entity.actions.get(0).events.get(0).name)
		]
	}

	@Test
	def void parseService() {
		'''
			package org.vaulttec.isis.script.test
			service Service1 {
				inject Object injection1
				action int action1 {
					body {
						42
					}
					event Event1
				}
			}
		'''.parse => [
			assertNoErrors
			assertEquals("org.vaulttec.isis.script.test", package.name)
			val entity = declaration as IsisService
			assertEquals("Service1", entity.name)
			assertEquals("injection1", entity.injections.get(0).name)
			assertEquals("action1", entity.actions.get(0).name)
			assertEquals("Event1", entity.actions.get(0).events.get(0).name)
		]
	}

	@Test
	def void parseBehaviour() {
		'''
			package org.vaulttec.isis.script.test
			behaviour Foo_text for String text {
				action String $$ {
					body {
						text
					}
				}
			}
		'''.parse => [
			assertNoErrors
			assertEquals("org.vaulttec.isis.script.test", package.name)
			val behaviour = declaration as IsisBehaviour
			assertEquals("Foo_text", behaviour.name)
			assertEquals("$$", behaviour.actions.get(0).name)
		]
	}

	@Test
	def void parseModule() {
		'''
			package org.vaulttec.isis.script.test
			module String
			entity Entity1 {
			}
		'''.parse => [
			assertNoErrors
			assertEquals("org.vaulttec.isis.script.test", package.name)
			val entity = declaration as IsisEntity
			assertEquals("Entity1", entity.name)
			assertEquals("java.lang.String", (entity.eContainer as IsisFile).module.type.qualifiedName)
		]
	}

}
