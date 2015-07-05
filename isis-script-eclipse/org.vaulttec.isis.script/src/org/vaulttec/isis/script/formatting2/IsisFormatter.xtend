/*
 * generated by Xtext
 */
package org.vaulttec.isis.script.formatting2;

import com.google.inject.Inject;
import org.eclipse.xtext.formatting2.IFormattableDocument;
import org.eclipse.xtext.xbase.annotations.formatting2.XbaseWithAnnotationsFormatter;
import org.eclipse.xtext.xbase.annotations.xAnnotations.XAnnotation;
import org.vaulttec.isis.script.dsl.IsisAction;
import org.vaulttec.isis.script.dsl.IsisActionParameter;
import org.vaulttec.isis.script.dsl.IsisEntity;
import org.vaulttec.isis.script.dsl.IsisEvent;
import org.vaulttec.isis.script.dsl.IsisFile;
import org.vaulttec.isis.script.dsl.IsisInjection;
import org.vaulttec.isis.script.dsl.IsisProperty;
import org.vaulttec.isis.script.dsl.IsisPropertyFeature;
import org.vaulttec.isis.script.dsl.IsisService;
import org.vaulttec.isis.script.dsl.IsisUiHint;
import org.vaulttec.isis.script.services.IsisGrammarAccess;

class IsisFormatter extends XbaseWithAnnotationsFormatter {
	
	@Inject extension IsisGrammarAccess

	def dispatch void format(IsisFile isisfile, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		format(isisfile.getPackage(), document);
		format(isisfile.getImportSection(), document);
		format(isisfile.getDeclaration(), document);
	}

	def dispatch void format(IsisEntity isisentity, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		for (XAnnotation annotations : isisentity.getAnnotations()) {
			format(annotations, document);
		}
		format(isisentity.getSuperType(), document);
		for (IsisInjection injections : isisentity.getInjections()) {
			format(injections, document);
		}
		for (IsisProperty properties : isisentity.getProperties()) {
			format(properties, document);
		}
		for (IsisAction actions : isisentity.getActions()) {
			format(actions, document);
		}
		for (IsisEvent events : isisentity.getEvents()) {
			format(events, document);
		}
		for (IsisUiHint uiHints : isisentity.getUiHints()) {
			format(uiHints, document);
		}
	}

	def dispatch void format(IsisService isisservice, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		for (XAnnotation annotations : isisservice.getAnnotations()) {
			format(annotations, document);
		}
		format(isisservice.getSuperType(), document);
		for (IsisInjection injections : isisservice.getInjections()) {
			format(injections, document);
		}
		for (IsisAction actions : isisservice.getActions()) {
			format(actions, document);
		}
	}

	def dispatch void format(IsisInjection isisinjection, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		format(isisinjection.getType(), document);
	}

	def dispatch void format(IsisProperty isisproperty, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		for (XAnnotation annotations : isisproperty.getAnnotations()) {
			format(annotations, document);
		}
		format(isisproperty.getType(), document);
		for (IsisPropertyFeature features : isisproperty.getFeatures()) {
			format(features, document);
		}
	}

	def dispatch void format(IsisPropertyFeature isispropertyfeature, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		format(isispropertyfeature.getExpression(), document);
	}

	def dispatch void format(IsisAction isisaction, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		for (XAnnotation annotations : isisaction.getAnnotations()) {
			format(annotations, document);
		}
		format(isisaction.getReturnType(), document);
		for (IsisActionParameter parameters : isisaction.getParameters()) {
			format(parameters, document);
		}
		format(isisaction.getExpression(), document);
	}

	def dispatch void format(IsisActionParameter isisactionparameter, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		for (XAnnotation annotations : isisactionparameter.getAnnotations()) {
			format(annotations, document);
		}
		format(isisactionparameter.getType(), document);
	}

	def dispatch void format(IsisUiHint isisuihint, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		format(isisuihint.getExpression(), document);
	}
}