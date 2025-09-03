Alias: $snomed = http://snomed.info/sct
Alias: $icd11 = http://id.who.int/icd/release/11/mms
Alias: $loinc = http://loinc.org


////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    ICD11Codes
Id:          ICD11Codes
Title:       "All ICD-11 codes"
Description: "All codes from ICD-11"
* ^experimental = false
* ^status = #active
* include codes from system $icd11

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    SnomedVaccineCodes
Id:          SnomedVaccineCodes
Title:       "SNOMED CT vaccine codes"
Description: "This value set includes SNOMED CT codes for identifying vaccines."
* ^experimental = false

* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement

The SNOMED International IPS Terminology is distributed by International Health Terminology Standards Development Organisation, trading as SNOMED International, and is subject the terms of the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/). For more information, see [SNOMED IPS Terminology](https://www.snomed.org/snomed-ct/Other-SNOMED-products/international-patient-summary-terminology)

The HL7 International IPS implementation guides incorporate SNOMED CT®, used by permission of the International Health Terminology Standards Development Organisation, trading as SNOMED International. SNOMED CT was originally created by the College of American Pathologists. SNOMED CT is a registered trademark of the International Health Terminology Standards Development Organisation, all rights reserved. Implementers of SNOMED CT should review [usage terms](http://www.snomed.org/snomed-ct/get-snomed-ct) or directly contact SNOMED International: info@snomed.org"
* ^experimental = false

* include codes from system $snomed where concept descendent-of #787859002


////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    LabResultFindings
Id:          lab-result-findings
Title:       "Lab result findings (SNOMED CT)"
Description: "This value set includes SNOMED CT codes for identifying laboratory test results."
* ^experimental = false

* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement

The SNOMED International IPS Terminology is distributed by International Health Terminology Standards Development Organisation, trading as SNOMED International, and is subject the terms of the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/). For more information, see [SNOMED IPS Terminology](https://www.snomed.org/snomed-ct/Other-SNOMED-products/international-patient-summary-terminology)

The HL7 International IPS implementation guides incorporate SNOMED CT®, used by permission of the International Health Terminology Standards Development Organisation, trading as SNOMED International. SNOMED CT was originally created by the College of American Pathologists. SNOMED CT is a registered trademark of the International Health Terminology Standards Development Organisation, all rights reserved. Implementers of SNOMED CT should review [usage terms](http://www.snomed.org/snomed-ct/get-snomed-ct) or directly contact SNOMED International: info@snomed.org"
* ^experimental = false

* include codes from system SCT where concept descendent-of #441742003 // Evaluation finding (finding)
* include codes from system SCT where concept descendent-of #362981000 // Qualifier value (qualifier value)

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    CompletedObservationStatus
Id:          completed-observation-status
Title:       "Completed observation status"
Description: "Contains a subset of <http://hl7.org/fhir/ValueSet/observation-status> for completed/amended observations."
* ^experimental = false

* ObsStatus#final
* ObsStatus#amended
* ObsStatus#corrected

////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem: IdentityAssuranceLevelCodeSystem
Id: identity-assurance-level-code-system
Title: "Identity Assurance Level Code System"
Description: "Code representing identity assurance level, based on NIST 800-63-3"
* ^experimental = false
* ^url =  "https://smarthealth.cards/ial"
* ^copyright = "Copyright Computational Health Informatics Program, Boston Children's Hospital, Boston, MA as part of the [SMART Health Cards Framework](https://smarthealth.cards/ial). Licensed under CC-BY 4.0 (<https://creativecommons.org/licenses/by/4.0/>)."

* ^caseSensitive = false

* #IAL1 "Name and birth date were self-asserted."
* #IAL1.2 "An unspecified ID was used to verify name and birth date."
* #IAL1.4 "A US state-issued photo ID or nationally-issued photo ID was used to verify name and birth date."
* #IAL2 "Either remote or in-person identity proofing is required. IAL2 requires identifying attributes to have been verified in person or remotely using, at a minimum, the procedures given in NIST Special Publication 800-63A."
* #IAL3 "In-person identity proofing is required. Identifying attributes must be verified by an authorized CSP representative through examination of physical documentation as described in NIST Special Publication 800-63A."


ValueSet:    IdentityAssuranceLevel
Id:          identity-assurance-level
Title:       "Identity Assurance Level"
Description: "Relevant identity assurance level codes, based on NIST 800-63-3. See <https://smarthealth.cards/ial> for details."
* ^experimental = false
* include codes from system IAL
* exclude IAL#IAL1


////////////////////////////////////////////////////////////////////////////////////////////////////


ValueSet:    SpecimenCollectionSupervisionStatus
Id:          specimen-collection-supervision-status
Title:       "Specimen Collection Supervision Status"
Description: "Relevant codes representing specimen collection supervision status"
* ^experimental = false
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement

The SNOMED International IPS Terminology is distributed by International Health Terminology Standards Development Organisation, trading as SNOMED International, and is subject the terms of the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/). For more information, see [SNOMED IPS Terminology](https://www.snomed.org/snomed-ct/Other-SNOMED-products/international-patient-summary-terminology)

The HL7 International IPS implementation guides incorporate SNOMED CT®, used by permission of the International Health Terminology Standards Development Organisation, trading as SNOMED International. SNOMED CT was originally created by the College of American Pathologists. SNOMED CT is a registered trademark of the International Health Terminology Standards Development Organisation, all rights reserved. Implementers of SNOMED CT should review [usage terms](http://www.snomed.org/snomed-ct/get-snomed-ct) or directly contact SNOMED International: info@snomed.org"
* SCT#1208526009 "Specimen collection by subject unsupervised by healthcare professional (finding)"
* SCT#1208525008 "Virtual supervision by healthcare professional of specimen collection by subject (finding)"
* SCT#1208524007 "In-person supervision by healthcare professional of specimen collection by subject (finding)"
* SCT#1208523001 "Specimen collection by healthcare professional (finding)"


////////////////////////////////////////////////////////////////////////////////////////////////////

Alias: $cvx = http://hl7.org/fhir/sid/cvx

ValueSet: ImmunizationAllCvxValueSet
Id: immunization-all-cvx
Title: "Immunization / All / CVX"
Description: "Contains all CVX codes from <https://www2.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx> as of 2025-09-03. This list of codes will not update automatically, so please refer to this URL for
the most up-to-date codes.the most up-to-date codes."

* ^copyright = ""

* ^version = "20250903"
* ^experimental = false

* $cvx#54 "adenovirus, type 4"
* $cvx#55 "adenovirus, type 7"
* $cvx#82 "adenovirus, unspecified formulation"
* $cvx#24 "Anthrax, pre-exposure prophylaxis, post-exposure prophylaxis"
* $cvx#19 "BCG"
* $cvx#27 "botulinum antitoxin"
* $cvx#26 "cholera, unspecified formulation"
* $cvx#29 "CMVIG"
* $cvx#56 "dengue fever tetravalent"
* $cvx#12 "diphtheria antitoxin"
* $cvx#28 "DT (pediatric)"
* $cvx#20 "DTaP"
* $cvx#106 "DTaP, 5 pertussis antigens"
* $cvx#107 "DTaP, unspecified formulation"
* $cvx#110 "DTaP-Hep B-IPV"
* $cvx#50 "DTaP-Hib"
* $cvx#120 "DTaP-Hib-IPV"
* $cvx#130 "DTaP-IPV"
* $cvx#22 "DTP-Hib"
* $cvx#102 "DTP-Hib-Hep B"
* $cvx#57 "hantavirus"
* $cvx#52 "Hep A, adult"
* $cvx#83 "Hep A, ped/adol, 2 dose"
* $cvx#84 "Hep A, ped/adol, 3 dose"
* $cvx#31 "Hep A, pediatric, unspecified formulation"
* $cvx#85 "Hep A, unspecified formulation"
* $cvx#104 "Hep A-Hep B"
* $cvx#30 "HBIG"
* $cvx#42 "Hep B, adolescent/high risk infant"
* $cvx#43 "Hep B, adult"
* $cvx#44 "Hep B, high-dosage, dialysis or IC"
* $cvx#45 "Hep B, unspecified formulation"
* $cvx#58 "Hep C"
* $cvx#59 "Hep E"
* $cvx#60 "herpes simplex 2"
* $cvx#46 "Hib (PRP-D)"
* $cvx#47 "Hib (HbOC)"
* $cvx#48 "Hib (PRP-T)"
* $cvx#49 "Hib (PRP-OMP)"
* $cvx#17 "Hib, unspecified formulation"
* $cvx#51 "Hib-Hep B"
* $cvx#61 "HIV"
* $cvx#118 "HPV, bivalent"
* $cvx#62 "HPV, quadrivalent"
* $cvx#86 "IG"
* $cvx#87 "IGIV"
* $cvx#14 "IG, unspecified formulation"
* $cvx#111 "Influenza, live, trivalent, intranasal, PF"
* $cvx#15 "influenza, split (incl. purified surface antigen)"
* $cvx#16 "influenza, whole"
* $cvx#88 "influenza, unspecified formulation"
* $cvx#123 "influenza, H5N1-1203"
* $cvx#10 "IPV"
* $cvx#89 "polio, unspecified formulation"
* $cvx#39 "Japanese encephalitis SC"
* $cvx#63 "Junin virus"
* $cvx#64 "leishmaniasis"
* $cvx#65 "leprosy"
* $cvx#66 "Lyme disease"
* $cvx#94 "MMRV"
* $cvx#67 "malaria"
* $cvx#68 "melanoma"
* $cvx#32 "meningococcal MPSV4"
* $cvx#103 "meningococcal C conjugate"
* $cvx#114 "meningococcal MCV4P"
* $cvx#108 "meningococcal ACWY, unspecified formulation"
* $cvx#69 "parainfluenza-3"
* $cvx#11 "pertussis"
* $cvx#23 "plague"
* $cvx#33 "pneumococcal polysaccharide PPV23"
* $cvx#100 "pneumococcal conjugate PCV 7"
* $cvx#109 "pneumococcal, unspecified formulation"
* $cvx#70 "Q fever"
* $cvx#18 "rabies, intramuscular injection"
* $cvx#40 "rabies, intradermal injection"
* $cvx#90 "rabies, unspecified formulation"
* $cvx#72 "rheumatic fever"
* $cvx#73 "Rift Valley fever"
* $cvx#34 "RIG"
* $cvx#119 "rotavirus, monovalent"
* $cvx#122 "rotavirus, unspecified formulation"
* $cvx#116 "rotavirus, pentavalent"
* $cvx#74 "rotavirus, tetravalent"
* $cvx#71 "RSV-IGIV"
* $cvx#93 "RSV-MAb"
* $cvx#38 "rubella/mumps"
* $cvx#76 "Staphylococcus bacterio lysate"
* $cvx#113 "Td (adult), 5 Lf tetanus toxoid, preservative free, adsorbed"
* $cvx#115 "Tdap"
* $cvx#35 "tetanus toxoid, adsorbed"
* $cvx#112 "tetanus toxoid, unspecified formulation"
* $cvx#77 "Tick-borne encephalitis vaccine (non-US)"
* $cvx#13 "TIG"
* $cvx#95 "TST-OT tine test"
* $cvx#96 "TST-PPD intradermal"
* $cvx#97 "TST-PPD tine test"
* $cvx#98 "TST, unspecified formulation"
* $cvx#78 "tularemia vaccine"
* $cvx#91 "typhoid, unspecified formulation"
* $cvx#25 "typhoid, oral"
* $cvx#41 "typhoid, parenteral"
* $cvx#53 "typhoid, parenteral, AKD (U.S. military)"
* $cvx#101 "typhoid, ViCPs"
* $cvx#75 "Vaccinia (smallpox, mpox), live"
* $cvx#105 "vaccinia (smallpox) diluted"
* $cvx#79 "vaccinia immune globulin"
* $cvx#21 "varicella"
* $cvx#81 "VEE, inactivated"
* $cvx#80 "VEE, live"
* $cvx#92 "VEE, unspecified formulation"
* $cvx#36 "VZIG"
* $cvx#117 "VZIG (IND)"
* $cvx#37 "yellow fever live"
* $cvx#121 "zoster live"
* $cvx#998 "no vaccine administered"
* $cvx#999 "unknown"
* $cvx#99 "RESERVED - do not use"
* $cvx#133 "Pneumococcal conjugate PCV 13"
* $cvx#134 "Japanese Encephalitis IM"
* $cvx#137 "HPV, unspecified formulation"
* $cvx#136 "Meningococcal MCV4O"
* $cvx#135 "Influenza, high-dose, trivalent, PF"
* $cvx#131 "typhus, historical"
* $cvx#132 "DTaP-IPV-HIB-HEP B, historical"
* $cvx#128 "Novel Influenza-H1N1-09, all formulations"
* $cvx#125 "Novel Influenza-H1N1-09, nasal"
* $cvx#126 "Novel influenza-H1N1-09, preservative-free"
* $cvx#127 "Novel influenza-H1N1-09"
* $cvx#138 "Td (adult)"
* $cvx#139 "Td(adult) unspecified formulation"
* $cvx#140 "Influenza, split virus, trivalent, PF"
* $cvx#129 "Japanese Encephalitis, unspecified formulation"
* $cvx#141 "Influenza, split virus, trivalent, preservative"
* $cvx#142 "tetanus toxoid, not adsorbed"
* $cvx#143 "Adenovirus types 4 and 7"
* $cvx#144 "influenza, seasonal, intradermal, preservative free"
* $cvx#145 "RSV-MAb (new)"
* $cvx#146 "DTaP,IPV,Hib,HepB"
* $cvx#147 "meningococcal MCV4, unspecified formulation"
* $cvx#148 "Meningococcal C/Y-HIB PRP"
* $cvx#149 "Influenza, live, quadrivalent, intranasal"
* $cvx#150 "Influenza, split virus, quadrivalent, PF"
* $cvx#151 "influenza nasal, unspecified formulation"
* $cvx#152 "Pneumococcal Conjugate, unspecified formulation"
* $cvx#153 "Influenza, MDCK, trivalent, PF"
* $cvx#154 "Hep A, IG"
* $cvx#155 "Influenza, recombinant, trivalent, PF"
* $cvx#156 "Rho(D)-IG"
* $cvx#157 "Rho(D) -IG IM"
* $cvx#158 "Influenza, split virus, quadrivalent, preservative"
* $cvx#159 "Rho(D) - Unspecified formulation"
* $cvx#160 "Influenza A monovalent (H5N1), ADJUVANTED-2013"
* $cvx#801 "AS03 Adjuvant"
* $cvx#161 "Influenza, injectable,quadrivalent, preservative free, pediatric"
* $cvx#162 "meningococcal B, recombinant"
* $cvx#163 "meningococcal B, OMV"
* $cvx#164 "meningococcal B, unspecified"
* $cvx#165 "HPV9"
* $cvx#166 "influenza, intradermal, quadrivalent, preservative free"
* $cvx#167 "meningococcal, unknown serogroups"
* $cvx#168 "Influenza, adjuvanted, trivalent, PF"
* $cvx#169 "Hep A, live attenuated"
* $cvx#170 "DTAP/IPV/HIB - non-US"
* $cvx#171 "Influenza, MDCK, quadrivalent, PF"
* $cvx#172 "cholera, WC-rBS"
* $cvx#173 "cholera, BivWC"
* $cvx#174 "cholera, live attenuated"
* $cvx#175 "Rabies - IM Diploid cell culture"
* $cvx#176 "Rabies - IM fibroblast culture"
* $cvx#177 "PCV10"
* $cvx#178 "OPV bivalent"
* $cvx#179 "OPV ,monovalent, unspecified"
* $cvx#180 "tetanus immune globulin"
* $cvx#181 "anthrax immune globulin"
* $cvx#182 "OPV, Unspecified"
* $cvx#183 "Yellow fever vaccine live - alt"
* $cvx#184 "Yellow fever, unspecified"
* $cvx#185 "Influenza, recombinant, quadrivalent, PF"
* $cvx#186 "Influenza, MDCK, quadrivalent, preservative"
* $cvx#187 "zoster recombinant"
* $cvx#188 "zoster, unspecified formulation"
* $cvx#189 "HepB-CpG"
* $cvx#190 "Typhoid conjugate vaccine (TCV)"
* $cvx#191 "meningococcal A polysaccharide (non-US)"
* $cvx#192 "meningococcal AC polysaccharide (non-US)"
* $cvx#193 "Hep A-Hep B, pediatric/adolescent"
* $cvx#194 "Influenza, Southern Hemisphere"
* $cvx#195 "DT, IPV adsorbed"
* $cvx#196 "Td, adsorbed, preservative free, adult use, Lf unspecified"
* $cvx#197 "Influenza, high-dose, quadrivalent, PF"
* $cvx#200 "influenza, Southern Hemisphere, pediatric, preservative free"
* $cvx#201 "Influenza, Southern Hemisphere, quadrivalent, PF"
* $cvx#202 "influenza, Southern Hemisphere, quadrivalent, with preservative"
* $cvx#198 "DTP-hepB-Hib Pentavalent Non-US"
* $cvx#203 "meningococcal conjugate quadrivalent, MenACWY-TT (MCV4)"
* $cvx#205 "Influenza, adjuvanted, quadrivalent, PF"
* $cvx#206 "Vaccinia, smallpox Mpox vaccine live, PF, SQ or ID injection"
* $cvx#207 "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5mL dose or 50 mcg/0.25mL dose"
* $cvx#208 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose"
* $cvx#213 "SARS-COV-2 (COVID-19) vaccine, UNSPECIFIED"
* $cvx#210 "COVID-19 vaccine, vector-nr, rS-ChAdOx1, PF, 0.5 mL"
* $cvx#212 "COVID-19 vaccine, vector-nr, rS-Ad26, PF, 0.5 mL"
* $cvx#204 "Ebola Zaire vaccine, live, recombinant, 1mL dose"
* $cvx#214 "Ebola, unspecified"
* $cvx#211 "COVID-19, subunit, rS-nanoparticle+Matrix-M1 Adjuvant, PF, 0.5 mL"
* $cvx#500 "COVID-19 Non-US Vaccine, Product Unknown"
* $cvx#501 "COVID-19 IV Non-US Vaccine (QAZCOVID-IN)"
* $cvx#502 "COVID-19 IV Non-US Vaccine (COVAXIN)"
* $cvx#503 "COVID-19 LAV Non-US Vaccine (COVIVAC)"
* $cvx#504 "COVID-19 VVnr Non-US Vaccine (Sputnik Light)"
* $cvx#505 "COVID-19 VVnr Non-US Vaccine (Sputnik V)"
* $cvx#506 "COVID-19 VVnr Non-US Vaccine (CanSino Biological Inc./Beijing Institute of Biotechnology"
* $cvx#507 "COVID-19 PS Non-US Vaccine (Anhui Zhifei Longcom Biopharm + Inst of Micro, Chinese Acad of Sciences)"
* $cvx#508 "COVID-19 PS Non-US Vaccine (Jiangsu Province Centers for Disease Control and Prevention)"
* $cvx#509 "COVID-19 PS Non-US Vaccine (EpiVacCorona)"
* $cvx#510 "COVID-19 IV Non-US Vaccine (BIBP, Sinopharm)"
* $cvx#511 "COVID-19 IV Non-US Vaccine (CoronaVac, Sinovac)"
* $cvx#215 "Pneumococcal conjugate PCV15, polysaccharide CRM197 conjugate, adjuvant, PF"
* $cvx#216 "Pneumococcal conjugate PCV20, polysaccharide CRM197 conjugate, adjuvant, PF"
* $cvx#219 "COVID-19, mRNA, LNP-S, PF, 3 mcg/0.2 mL dose, tris-sucrose"
* $cvx#217 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose, tris-sucrose"
* $cvx#218 "COVID-19, mRNA, LNP-S, PF, 10 mcg/0.2 mL dose, tris-sucrose"
* $cvx#220 "HepB recombinant, 3-antigen, Al(OH)3"
* $cvx#221 "COVID-19, mRNA, LNP-S, PF, 50 mcg/0.5 mL dose"
* $cvx#222 "Tick-borne encephalitis, unspecified"
* $cvx#223 "Tick-borne encephalitis, inactivated, PF, 0.25mL"
* $cvx#224 "Tick-borne encephalitis, inactivated, PF, 0.5mL"
* $cvx#225 "COVID-19, D614, recomb, preS dTM, AS03 adjuvant add, PF, 5mcg/0.5mL"
* $cvx#226 "COVID-19, D614, recomb, preS dTM, AS03 adjuvant add, PF, 10mcg/0.5mL"
* $cvx#512 "SARS-COV-2 COVID-19 VLP Non-US Vaccine (Medicago, Covifenz)"
* $cvx#513 "SARS-COV-2 COVID-19 PS Non-US Vaccine (Anhui Zhifei Longcom, Zifivax)"
* $cvx#514 "SARS-COV-2 COVID-19 DNA Non-US Vaccine (Zydus Cadila, ZyCoV-D)"
* $cvx#515 "SARS-COV-2 COVID-19 PS Non-US Vaccine (Medigen, MVC-COV1901)"
* $cvx#516 "COV-2 COVID-19 Inactivated Non-US Vaccine Product (Minhai Biotechnology Co, KCONVAC)"
* $cvx#517 "SARS-COV-2 COVID-19 PS Non-US Vaccine (Biological E Limited, Corbevax)"
* $cvx#227 "COVID-19, mRNA, LNP-S, PF, pediatric 50 mcg/0.5 mL dose"
* $cvx#228 "COVID-19, mRNA, LNP-S, PF, pediatric 25 mcg/0.25 mL dose"
* $cvx#229 "COVID-19, mRNA, LNP-S, bivalent, PF, 50 mcg/0.5 mL or 25mcg/0.25 mL dose"
* $cvx#301 "COVID-19, mRNA, LNP-S, bivalent, PF, 10 mcg/0.2 mL dose"
* $cvx#300 "COVID-19, mRNA, LNP-S, bivalent, PF, 30 mcg/0.3 mL dose"
* $cvx#230 "COVID-19, mRNA, LNP-S, bivalent, PF, 10 mcg/0.2 mL"
* $cvx#518 "COVID-19 Inactivated, Non-US Vaccine (VLA2001, Valneva)"
* $cvx#519 "COVID-19 mRNA, bivalent, original/Omicron BA.1, Non-US Vaccine (Spikevax Bivalent), Moderna"
* $cvx#520 "COVID-19 mRNA, bivalent, original/Omicron BA.1, Non-US Vaccine Product, Pfizer-BioNTech"
* $cvx#521 "COVID-19 SP, protein-based, adjuvanted (VidPrevtyn Beta), Sanofi-GSK"
* $cvx#231 "influenza, Southern Hemisphere, high-dose, quadrivalent"
* $cvx#303 "RSV, recombinant, protein subunit RSVpreF, adjuvant reconstituted, 0.5 mL, PF"
* $cvx#304 "Respiratory syncytial virus (RSV), unspecified"
* $cvx#305 "RSV, bivalent, protein subunit RSVpreF, diluent reconstituted, 0.5 mL, PF"
* $cvx#306 "RSV, mAb, nirsevimab-alip, 0.5 mL, neonate to 24 months"
* $cvx#307 "RSV, mAb, nirsevimab-alip, 1 mL, neonate to 24 months"
* $cvx#313 "COVID-19, subunit, rS-nanoparticle, adjuvanted, PF, 5 mcg/0.5 mL"
* $cvx#308 "COVID-19, mRNA, LNP-S, PF, tris-sucrose, 3 mcg/0.3 mL"
* $cvx#309 "COVID-19, mRNA, LNP-S, PF, tris-sucrose, 30 mcg/0.3 mL"
* $cvx#310 "COVID-19, mRNA, LNP-S, PF, tris-sucrose, 10 mcg/0.3 mL"
* $cvx#312 "COVID-19, mRNA, LNP-S, PF, 50 mcg/0.5 mL"
* $cvx#311 "COVID-19, mRNA, LNP-S, PF, 25 mcg/0.25 mL"
* $cvx#315 "Respiratory syncytial virus (RSV) MAB, unspecified"
* $cvx#314 "Respiratory syncytial virus (RSV) vaccine, unspecified"
* $cvx#316 "Meningococcal polysaccharide (MenACWY-TT conjugate), (MenB), PF"
* $cvx#317 "Chikungunya live attenuated vaccine, 0.5 mL, PF"
* $cvx#318 "Anthrax, post-exposure prophylaxis"
* $cvx#319 "Anthrax vaccine, unspecified"
* $cvx#320 "Influenza, MDCK, trivalent, preservative"
* $cvx#321 "Influenza-avian, H5N8, monovalent, PF"
* $cvx#322 "Influenza-avian, H5N8, monovalent, preservative"
* $cvx#324 "Poliovirus, inactivated, fractional-dose (fIPV)"
* $cvx#323 "Influenza-avian, H5, unspecified formulation"
* $cvx#326 "RSV, mRNA, injectable, PF"
* $cvx#327 "Pneumococcal conjugate PCV21, polysaccharide CRM197 conjugate, PF"
* $cvx#328 "Meningococcal oligosaccharide (MenACWY), (MenB), PF"
* $cvx#329 "Chikungunya, VLP, recombinant, 0.8 mL, PF"
* $cvx#330 "Dengue fever, unspecified"
* $cvx#331 "Influenza, Southern Hemisphere, trivalent, PF"
* $cvx#325 "Vaccinia (smallpox, mpox), unspecified"
* $cvx#332 "RSV, mAb, clesrovimab-cfor, 0.7 mL, neonate and infant, PF"
* $cvx#333 "Influenza, live, trivalent, intranasal, self/caregiver admin, PF"
* $cvx#302 "COVID-19, mRNA, LNP-S, bivalent, PF, 3 mcg/0.2 mL dose"

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet: LabQualitativeResultValueSet
Id: lab-qualitative-result
Title: "Qualitative infectious disease-related lab test result codes"
Description: "This value set includes a codes to identify the results of qualitative lab tests related to infectious diseases."
* ^experimental = false

* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2022, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc

The SNOMED CT codes in this ValueSet are part of SNOMED GPS, which is produced by SNOMED International under the terms of the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/).

Additional information about this license specific to SNOMED International's release of the GPS:

- SNOMED CT is © and ® SNOMED International. The right to maintain the GPS remains vested exclusively in SNOMED International.
- The Licensee can redistribute the GPS.
- The Licensee can create derivatives or implementation-related products and services based on the GPS.
- The Licensee cannot claim that SNOMED International or any of its Members endorses the Licensee's derivative because it uses content from the GPS.
- Neither SNOMED International nor any of the contributors accept any liability for the Licensee's use or redistribution of the GPS.
- SNOMED CT® was originally created by the College of American Pathologists.

Without obtaining prior written permission from SNOMED International, you are expressly prohibited from using, distributing or reproducing the SNOMED International, SNOMED CT or SNOMED GPS logo, service mark or trademark. Please review all terms and conditions of use [here](http://www.snomed.org/terms-and-conditions)."

* ^version = "2023.1"

* $snomed#10828004 "Positive (qualifier value)"
* $snomed#11214006 "Reactive (qualifier value)"
* $snomed#125154007 "Specimen unsatisfactory for evaluation (finding)"
* $snomed#131194007 "Non-reactive (qualifier value)"
* $snomed#260373001 "Detected (qualifier value)"
* $snomed#260385009 "Negative (qualifier value)"
* $snomed#260415000 "Not detected (qualifier value)"
* $snomed#407479009 "Influenza A virus (organism)"
* $snomed#407480007 "Influenza B virus (organism)"
* $snomed#415684004 "Suspected (qualifier value)"
* $snomed#419984006 "Inconclusive (qualifier value)"
* $snomed#42425007 "Equivocal (qualifier value)"
* $snomed#455371000124106 "Invalid result (qualifier value)"
* $snomed#720735008 "Presumptive positive (qualifier value)"
* $snomed#82334004 "Indeterminate (qualifier value)"
* $snomed#840533007 "Severe acute respiratory syndrome coronavirus 2 (organism)"

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet: LabQualitativeTestCovidValueSet
Id: lab-qualitative-test-covid
Title: "LOINCs identifying qualitative COVID lab tests"
Description: "This value set includes a subset of the LOINCs found at <https://loinc.org/sars-cov-2-and-covid-19/> that identify COVID-19-related laboratory tests. Only those laboratory tests that include
qualitative results we believe to be useful in SMART Health Cards are included.qualitative results we believe to be useful in SMART Health Cards are included."


* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2022, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^version = "2023.1"
* ^experimental = false

* $loinc#94307-6 "SARS-CoV-2 N gene Spec Ql NAA N1"
* $loinc#94308-4 "SARS-CoV-2 N gene Spec Ql NAA N2"
* $loinc#94309-2 "SARS-CoV-2 RNA Spec Ql NAA+probe"
* $loinc#94310-0 "SARS-related CoV N Spec Ql NAA N3"
* $loinc#94314-2 "SARS-CoV-2 RdRp Spec Ql NAA+probe"
* $loinc#94315-9 "SARS-rel CoV E gene Spec Ql NAA+probe"
* $loinc#94316-7 "SARS-CoV-2 N gene Spec Ql NAA+probe"
* $loinc#94500-6 "SARS-CoV-2 RNA Resp Ql NAA+probe"
* $loinc#94502-2 "SARS-rel CoV RNA Resp Ql NAA+probe"
* $loinc#94507-1 "SARS-CoV-2 IgG SerPlBld Ql IA.rapid"
* $loinc#94508-9 "SARS-CoV-2 IgM SerPlBld Ql IA.rapid"
* $loinc#94532-9 "SARS-rel CoV+MERS RNA Resp Ql NAA+probe"
* $loinc#94533-7 "SARS-CoV-2 N gene Resp Ql NAA+probe"
* $loinc#94534-5 "SARS-CoV-2 RdRp Resp Ql NAA+probe"
* $loinc#94547-7 "SARS-CoV-2 IgG+IgM SerPl Ql IA"
* $loinc#94558-4 "SARS-CoV-2 Ag Resp Ql IA.rapid"
* $loinc#94559-2 "SARS-CoV-2 ORF1ab Resp Ql NAA+probe"
* $loinc#94562-6 "SARS-CoV-2 IgA SerPl Ql IA"
* $loinc#94563-4 "SARS-CoV-2 IgG SerPl Ql IA"
* $loinc#94564-2 "SARS-CoV-2 IgM SerPl Ql IA"
* $loinc#94565-9 "SARS-CoV-2 RNA Nph Ql NAA+non-probe"
* $loinc#94639-2 "SARS-CoV-2 ORF1ab Spec Ql NAA+probe"
* $loinc#94640-0 "SARS-CoV-2 S gene Resp Ql NAA+probe"
* $loinc#94641-8 "SARS-CoV-2 S gene Spec Ql NAA+probe"
* $loinc#94647-5 "SARSr-CoV RNA Spec Ql NAA+probe"
* $loinc#94660-8 "SARS-CoV-2 RNA SerPl Ql NAA+probe"
* $loinc#94756-4 "SARS-CoV-2 N gene Resp Ql NAA N1"
* $loinc#94757-2 "SARS-CoV-2 N gene Resp Ql NAA N2"
* $loinc#94758-0 "SARS-rel CoV E gene Resp Ql NAA+probe"
* $loinc#94759-8 "SARS-CoV-2 RNA Nph Ql NAA+probe"
* $loinc#94760-6 "SARS-CoV-2 N gene Nph Ql NAA+probe"
* $loinc#94761-4 "SARS-CoV-2 IgG DBS Ql IA"
* $loinc#94762-2 "SARS-CoV-2 Ab SerPl Ql IA"
* $loinc#94763-0 "SARS-CoV-2 Spec Ql Cult"
* $loinc#94765-5 "SARS-rel CoV E gene SerPl Ql NAA+probe"
* $loinc#94766-3 "SARS-CoV-2 N gene SerPl Ql NAA+probe"
* $loinc#94767-1 "SARS-CoV-2 S gene SerPl Ql NAA+probe"
* $loinc#94768-9 "SARS-CoV-2 IgA SerPlBld Ql IA.rapid"
* $loinc#94822-4 "SARS-CoV-2 RNA Sal Ql Seq"
* $loinc#94845-5 "SARS-CoV-2 RNA Sal Ql NAA+probe"
* $loinc#95125-1 "SARS-CoV-2 IgA+IgM SerPl Ql IA"
* $loinc#95209-3 "SARS-CoV+SARS-CoV-2 Ag Resp Ql IA.rapid"
* $loinc#95406-5 "SARS-CoV-2 RNA Nose Ql NAA+probe"
* $loinc#95409-9 "SARS-CoV-2 N gene Nose Ql NAA+probe"
* $loinc#95411-5 "SARS-CoV-2 NAb Ser Ql pVNT"
* $loinc#95416-4 "SARS-CoV-2 IgM DBS Ql IA"
* $loinc#95423-0 "FLUABV + SARS-CoV-2 Resp NAA+probe"
* $loinc#95424-8 "SARS-CoV-2 RNA Resp Ql Seq"
* $loinc#95425-5 "SARS-CoV-2 N gene Sal Ql NAA+probe"
* $loinc#95542-7 "SARS-CoV-2 Ab SerPlBld Ql IA.rapid"
* $loinc#95608-6 "SARS-CoV-2 RNA Resp Ql NAA+non-probe"
* $loinc#95609-4 "SARS-CoV-2 S gene Resp Ql Seq"
* $loinc#95823-1 "SARS-rel CoV E gene Sal Ql NAA+probe"
* $loinc#95824-9 "SARS-CoV-2 ORF1ab Sal Ql NAA+probe"
* $loinc#95825-6 "SARS-CoV-2 Ab DBS Ql IA"
* $loinc#95970-0 "SARS-CoV-2 TCRB Bld Ql Seq"
* $loinc#95971-8 "SARS-CoV-2 IFN-g Bld Ql"
* $loinc#96091-4 "SARS-CoV-2 RdRp Sal Ql NAA+probe"
* $loinc#96119-3 "SARS-CoV-2 Ag Upper resp Ql IA"
* $loinc#96120-1 "SARS-CoV-2 RdRp Lower resp Ql NAA+probe"
* $loinc#96121-9 "SARS-rel CoV E gene Low resp Ql NAA+prb"
* $loinc#96122-7 "SARS-rel CoV E gene Upper resp Ql NAA+prb"
* $loinc#96123-5 "SARS-CoV-2 RdRp Upper resp Ql NAA+probe"
* $loinc#96448-6 "SARS-CoV-2 N gene Sal Ql NAA N1"
* $loinc#96603-6 "SARS-CoV-2 S RBD NAb SerPl Ql sVNT"
* $loinc#96752-1 "SARS-CoV-2 S gene mut Spec Ql"
* $loinc#96763-8 "SARS-CoV-2 E gene Resp Ql NAA+probe"
* $loinc#96765-3 "SARS-CoV-2 S gene Sal Ql NAA+probe"
* $loinc#96797-6 "SARS-CoV-2 RNA OPA wash Ql NAA+probe"
* $loinc#96829-7 "SARS-CoV-2 RNA Spec Donr Ql NAA+probe"
* $loinc#96957-6 "SARS-CoV-2 M gene Upper resp Ql NAA+prb"
* $loinc#96958-4 "SARS-CoV-2 N gene Sal Ql NAA N2"
* $loinc#96986-5 "SARS-CoV-2 N gene Nose Ql NAA+non-probe"
* $loinc#97097-0 "SARS-CoV-2 Ag Upper resp Ql IA.rapid"
* $loinc#97098-8 "SARS-CoV-2 Nsp2 Upper resp Ql NAA+probe"
* $loinc#98069-8 "SARS-CoV-2 Ab Sal Ql IA.rapid"
* $loinc#98131-6 "SARS-CoV-2 ORF1b Resp Ql NAA+probe"
* $loinc#98132-4 "SARS-CoV-2 ORF1a Resp Ql NAA+probe"
* $loinc#98493-0 "SARS-CoV-2 ORF1b Sal Ql NAA+probe"
* $loinc#98494-8 "SARS-CoV-2 ORF1a Sal Ql NAA+probe"
* $loinc#99596-9 "SARS-CoV-2 N IgG SerPl Ql IA"
* $loinc#99597-7 "SARS-CoV-2 S IgG SerPl Ql IA"
* $loinc#99772-6 "SARS-CoV-2 IFN-g Bld-Imp"