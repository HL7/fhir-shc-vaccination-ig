# Vaccine Code Examples

See documentation at [Implentation Guide Immunization Allowable Data](http://build.fhir.org/ig/dvci/vaccine-credential-ig/branches/main/StructureDefinition-vaccination-credential-immunization.html).

This directory holds json files demonstrating each code system.

## Code Systems

| System    | URL                                   | Value set          | Manufacturer Required? |
| :-------: | :------------------------------------ | :----------------: | :--------------------: |
| GTIN      | <https://www.gs1.org/gtin>            | VaccineProductGTIN | NO                     |
| CVX       | <http://hl7.org/fhir/sid/cvx>         | VacccineProductCVX | NO (for Covid)         |
| AIR       | <https://www.humanservices.gov.au/organisations/health-professionals/enablers/air-vaccine-code-formats> | Austrailian Immunisation Register Vaccine | NO |
| SNOMED CT | <http://snomed.info/sct>              | VaccineTypeSNOMED  | YES                    |
| ICD-11    | <http://id.who.ind/icd11/mms>         | VaccineTargetICD11 | YES                    |
| ATC/DDD   | <https://www.whocc.no/atc_ddd_index/> | VaccineTargetATC   | YES                    |


## Approved Vaccines according to [Regulatory Affairs Professionals Society](https://www.raps.org/news-and-articles/news-articles/2020/3/covid-19-vaccine-tracker)

| Name          | Developer                                                                         | Nationality     |
| :-----------: | :-------------------------------------------------------------------------------- | :-------------- |
| Comirnaty     | Pfizer; BioNTech; Fosun Pharma                                                    | Multinational   |
| Moderna       | Moderna; BARDA; NIAID                                                             | US              |
| AstraZeneca   | BARDA; OWS                                                                        | UK              | 
| Sputnik V     | Gamaleya Res. Inst., Acellena Contract Drug R&D                                   | Russia          |
| Sputnik Light | Gamaleya Res. Inst., Acellena Contract Drug R&D                                   | Russia          |
| Janssen       | Janssen Vaccines Johnson & Johnson                                                | Netherlands, US |
| CoronaVac     | Sinovac                                                                           | China           |
| BBIBP-CorV    | Beijing Inst. of Bio. Products; Sinopharm                                         | China           |
| EpiVacCorona  | Fed. Budgetary Res. Inst. State Res. Ctr of Vir. & Biotech.                       | Russia          |
| Convidicea    | CanSino Biologics                                                                 | China           |
| Covaxin       | Bharat Biotech, ICMR; Ocugen                                                      | India           |
| WIBP-CorV     | Wuhan Inst. of Bio. Products; Sinopharm                                           | China           |
| CoviVac       | Chumakov Fed. Sci. Ctr for R&D of Imm. and Biological Products                    | Russia          |
| ZF2001        | Anhui Zhifei Longcom Biopharm.; Inst. of Microbio. of the Chinese Academy of Sci. | China           |
| QazVac        | Res. Inst. for Biological Safety Problems                                         | Kazakhstan      |
| Unnamed       | Minhai Biotechnology Co.; Kangtai Biological Products Co. Ltd.                    | China           |
| Novavax       | Novavax                                                                           | US              |

Also added Novavax vaccine, although it is not yet approved as of Jun 9th, 2021.

## Vaccine Codes

Blank means values are missing, and " " indicates same value for each row.

| Vaccine           | GTIN            | CVX      | AIR      | SNOMED CT  | ICD-11    | ATC/DDD  |
| :---------------: | :-------------: | :------: | :------: | :-------:  | :-------: | :------: |
| Pfizer            |                 | 208      | COMIRN   | 1119305005 |  XM0GQ8   | J07BX03  |
| Moderna           | 30380777700688  | 207      |          |   "   "    |  XM0GQ8   |  "   "   |
| AstraZeneca       |                 | 210      | COVAST   |   "   "    |  XM9QW8   |  "   "   |
| Sputnik V         |                 | 213      |          |   "   "    |  XM9QW8   |  "   "   |
| Sputnik Light     |                 | 213      |          |   "   "    |  XM9QW8   |  "   "   |
| Janssen           | 00359676580157  | 212      |          |   "   "    |  XM9QW8   |  "   "   |
| Sinovac           |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| Beijing Sinopharm |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| EpiVacCorona      |                 | 213      |          |   "   "    |  XM5JC5   |  "   "   |
| CanSino           |                 | 213      |          |   "   "    |  XM9QW8   |  "   "   |
| Covaxin Bharat    |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| Wuhan Sinopharm   |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| CoviVac Russia    |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| ZF2001            |                 | 213      |          |   "   "    |  XM5JC5   |  "   "   |
| QazVac            |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| Minha             |                 | 213      |          |   "   "    |  XM1NL1   |  "   "   |
| Novavax           |                 | 211      |          |   "   "    |  XM5JC5   |  "   "   |

Pfizer NDC: 59267-1000-2

**CVX uses 213 for (any) unspecified COVID vaccine, ICD-11 has "parent code" XM68M6 for any COVID vaccine, AIR only registers vaccines approved in Australia**


## Manufacturer Codes
| Manufacturer      | MVX  | GLN            |
|:-----------------:|:----:|:--------------:|
| Pfizer            | PFR  | 0863772000001  |
| Moderna           | MOD  | 0380777000008  |
| AstraZeneca       | ASZ  |                |
| Sputnik V         |      |                |
| Sputnik Light     |      |                |
| Janssen           | JSN  |                |
| Sinovac           |      |                |
| Beijing Sinopharm |      |                |
| EpiVacCorona      |      |                |
| CanSino           |      |                |
| Covaxin Bharat    |      |                |
| Wuhan Sinopharm   |      |                |
| CoviVac Russia    |      |                |
| ZF2001            |      |                |
| QazVac            |      |                |
| Minha             |      |                |
| Novavax           | NVX  | 0380631000007  |

Sources:
 - [CVX Codes](https://www.cdc.gov/vaccines/programs/iis/COVID-19-related-codes.html)
 - [ICD-11 Codes](https://icd.who.int/browse11/l-m/en#/http%3a%2f%2fid.who.int%2ficd%2fentity%2f873941688)
   + [Vaccine classes](https://www.raps.org/news-and-articles/news-articles/2020/3/covid-19-vaccine-tracker)
   + ZF2001 is viral protein subunit: <https://www.thelancet.com/journals/laninf/article/PIIS1473-3099(21)00127-4/fulltext>
 - [AIR Codes](https://www.servicesaustralia.gov.au/organisations/health-professionals/services/medicare/medicare-online-software-developers/resources/formats-exchange-electronic-data/air-vaccine-code-formats)
   + Australia has only approved two vaccines: <https://www.health.gov.au/initiatives-and-programs/covid-19-vaccines/getting-vaccinated-for-covid-19/which-covid-19-vaccine-will-i-receive>
 - [SNOMED CT Codes](https://confluence.ihtsdotools.org/display/snomed/SNOMED+CT+COVID-19+Related+Content) (same code for each)
 - [ATC/DDD Codes](https://www.whocc.no/lists_of__temporary_atc_ddds_and_alterations/new_atc_5th_levels/)
 - [GTIN Lookup](https://gepir.gs1.org/index.php/search-by-gtin)
 - [MVX Codes](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=tradename)
 - [GLN Lookup](https://gepir.gs1.org/index.php/search-by-party-name)

Note: SNOMED for UK has a seperate code system for each medical product: [Covid vaccine products](https://termbrowser.nhs.uk/?perspective=full&conceptId1=39330711000001103&edition=uk-edition&release=v20210512&server=https://termbrowser.nhs.uk/sct-browser-api/snomed&langRefset=999000681000001101,999001251000000103)

```
SNOMED Medical Product >> Vaccine >> Covid Vaccines >> Pfizer: 39116111000001100
                                                      Moderna: 39326811000001106
                                                  AstraZeneca: 39116211000001106
                                                      Novavax: 39478211000001100
                                (Inactivated Adjuvant) Valvea: 39375211000001103
```
