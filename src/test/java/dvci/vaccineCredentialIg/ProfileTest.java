package dvci.vaccinecredentialig;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.hl7.fhir.exceptions.FHIRException;
import org.hl7.fhir.r5.model.FhirPublication;
import org.hl7.fhir.r5.model.OperationOutcome;
import org.hl7.fhir.r5.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.r5.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.validation.ValidationEngine;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProfileTest {
  private static final String DEF_TX = "http://tx.fhir.org";
  private static String DEF_TXLOG = null;
  private static ValidationEngine validator;
  private static final Logger logger = LoggerFactory.getLogger(ProfileTest.class);

  /**
   * Run setup before class.
   *
   * @throws Exception validator exceprion
   */
  @BeforeAll
  public static void setup() throws Exception {
    String txsrvr = System.getProperty("txsrvr") != null ? System.getProperty("txsrvr") : DEF_TX;
    String txLog = System.getProperty("txLog") != null ? System.getProperty("txLog") : DEF_TXLOG;
    validator = new ValidationEngine("hl7.fhir.r4.core#4.0.1", 
      txsrvr, txLog, FhirPublication.R4, true, "4.0.1");
    validator.getContext().loadFromFolder("fsh-generated/resources");
  }

  /**
   * Executes test cases for which no errors should occur.
   * 
   * @param source location of source file containing resource to validate
   * @param profile FHIR profile against which to validate resource
   * @throws FHIRException validation exception
   * @throws IOException validation exception
   */
  @ParameterizedTest
  @CsvFileSource(resources = "/tests.csv", numLinesToSkip = 1)
  public void testValidationNoErrors(String source, String profile)
      throws FHIRException, IOException {
    List<String> profiles = new ArrayList<>();
    profiles.add(profile);
    OperationOutcome outcome = validator.validate(source, profiles);

    ArrayList<OperationOutcomeIssueComponent> errors = filterErrors(outcome);
    StringBuilder errorMessages = new StringBuilder();
    StringBuilder messages = new StringBuilder();
    outcome.getIssue().forEach(issue -> {
      messages.append(issue.getUserData("source.vm"));
      messages.append("\n");
    });
    errors.forEach(error -> {
      errorMessages.append(error.getUserData("source.vm"));
      errorMessages.append("\n");
    });

    if (outcome.getIssue().size() > 0) {
      logger.info("Issues for {},  profile {}", source, profile);
      logger.info(messages.toString());
    }
    if (errors.size() > 0) {
      Assertions.fail("source: " + source
          + ", profile: " + profile + "\n" + errorMessages.toString());
    }
  }

  /**
   * Executes test cases for which validation issues should occur. 
   * Filters by optional parameters. Will pass if at least one match.
   * 
   * @param source location of source file containing resource to validate
   * @param profile FHIR profile against which to validate resource
   * @param expectedIssueSeverity issue severity, optional
   * @param expectedLocation issue expression location, optional, can be partial
   * @param expectedErrorMessage issue message, optional, can be partial
   * @throws FHIRException validation exception
   * @throws IOException validation exception
   */
  @ParameterizedTest
  @CsvFileSource(resources = "/tests_errors.csv", numLinesToSkip = 1)
  public void testValidationExpectedErrors(String source, String profile, 
        IssueSeverity expectedIssueSeverity,
        String expectedLocation, String expectedErrorMessage) 
      throws FHIRException, IOException {
    List<String> profiles = new ArrayList<>();
    profiles.add(profile);
    OperationOutcome outcome = validator.validate(source, profiles);

    Assertions.assertTrue(outcome.getIssue().stream()
        .filter(issue -> expectedIssueSeverity == null 
          || issue.getSeverity().equals(expectedIssueSeverity))
        .filter(issue -> expectedErrorMessage == null 
          || issue.getDetails().getText().contains(expectedErrorMessage))
        .filter(issue -> expectedLocation == null 
          || issue.getExpression().stream()
            .filter(s -> s.asStringValue().contains(expectedLocation))
            .collect(Collectors.toList()).size() > 0)
        .collect(Collectors.toList()).size() > 0,
        "Should throw level=" + expectedIssueSeverity
          + ", location=" + expectedLocation 
          + ", message=" + expectedErrorMessage);
  }

  private ArrayList<OperationOutcomeIssueComponent> filterErrors(OperationOutcome outcome) {
    // manually filter out errors that are due to validator inconsistencies
    ArrayList<OperationOutcomeIssueComponent> errors = new ArrayList<>();
    for (OperationOutcomeIssueComponent issue : outcome.getIssue()) {
      if (issue.getSeverity().equals(IssueSeverity.ERROR)) {
        if (issue.getDetails().getText().contains(
            "Bundle.entry:vaccinationCredentialImmunization: minimum required = 1, but only found 0"
            )) {
          // if there is an Immunization entry with errors, then ignore this error
          if (!findImmunizationError(outcome)) {
            errors.add(issue);
          }
        } else if (!ignoreError(issue)) {
          errors.add(issue);
        }
      }
    }

    return errors;
  }

  private boolean ignoreError(OperationOutcomeIssueComponent issue) {
    if (issue.getDetails().getText().equalsIgnoreCase(
        "Relative URLs must be of the format [ResourceName]/[id].  Encountered resource:0")) {
      return true;
    } else if (issue.getDetails().getText()
        .equalsIgnoreCase("Resource requires an id, but none is present")) {
      return true;
    }

    return false;
  }

  private boolean findImmunizationError(OperationOutcome outcome) {
    // find error entry for Immunization resource type that has an ignored error
    for (OperationOutcomeIssueComponent issue : outcome.getIssue()) {
      if (issue.getSeverity().equals(IssueSeverity.ERROR)) {
        if (issue.getExpression().stream()
            .filter(s -> s.asStringValue().contains("resource.ofType(Immunization)"))
            .collect(Collectors.toList()).size() > 0) {
          if (ignoreError(issue)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
