package dvci.vaccineCredentialIg;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.hl7.fhir.r5.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.exceptions.FHIRException;
import org.hl7.fhir.r5.model.FhirPublication;
import org.hl7.fhir.r5.model.OperationOutcome;
import org.hl7.fhir.r5.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.r5.utils.EOperationOutcome;
import org.hl7.fhir.validation.ValidationEngine;

public class ProfileTest {
    private static final String DEF_TX = "http://tx.fhir.org";
    private static ValidationEngine validator;
    private static String txLog = null;
    private static final Logger logger = LoggerFactory.getLogger(ProfileTest.class);

    @BeforeAll
    public static void setup() throws Exception {
        validator = new ValidationEngine("hl7.fhir.r4.core#4.0.1", DEF_TX, txLog, FhirPublication.R4, true, "4.0.1");
        validator.getContext().loadFromFolder("fsh-generated/resources");
    }

    @ParameterizedTest
    @CsvFileSource(resources = "/tests.csv", numLinesToSkip = 1)
    public void testValidationNoErrors(String source, String profile)
            throws FHIRException, IOException, EOperationOutcome {
        List<String> profiles = new ArrayList<>();
        profiles.add(profile);
        OperationOutcome outcome = validator.validate(source, profiles);

        int countErrors = 0;
        StringBuilder errors = new StringBuilder();
        StringBuilder messages = new StringBuilder();
        for (OperationOutcomeIssueComponent issue : outcome.getIssue()) {
            messages.append(issue.getUserData("source.vm"));
            messages.append("\n");
            if (issue.getSeverity().equals(IssueSeverity.ERROR)) {
                countErrors++;
                errors.append(issue.getUserData("source.vm"));
                errors.append("\n");
            }
        }

        if (outcome.getIssue().size() > 0) {
            logger.info("Issues for {},  profile {}", source, profile);
            logger.info(messages.toString());
        }
        if (countErrors > 0) {
            Assertions.fail("source: " + source + ", profile: " + profile + "\n" + errors.toString());
        }
    }
}