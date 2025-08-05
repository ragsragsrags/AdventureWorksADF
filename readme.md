This is an ETL workflow on OLTP Adventureworks database to a warehouse database for Azure Data Factory.  This is only the sales data (finance data is not included) and one-time only. This is to assume you have azure subscription.  Here are some relevant documents:

Create server/database: https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql&tabs=azure-portal
Connect to server: https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-ssms?view=azuresql

I'm using the 2022 version of the database sample: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

![image](https://github.com/user-attachments/assets/412ab68b-9456-431d-b369-60cdc8fe64af)

Restore the backup db first in the local sql server.  Run the updates: AdventureWorks2022_Updates.sql

Then, I've deployed it to the Azure Data Factory using this step: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

<img width="876" height="837" alt="image" src="https://github.com/user-attachments/assets/f7fbe3a8-5e40-47b3-8a8d-2c2a1250d14d" />

Run this script to create Person.PersonDemomgraphics table and populate the data in the azure server: AdventureWorks2022_Updates.sql

For the datawarehouse database, run this script to the local server and deploy to azure using the steps above: AdventureWorksDW2022_Database.sql 

Also, you need to properly connect to the azure sql database.  I'm using this document: https://learn.microsoft.com/en-us/azure/data-factory/connector-azure-sql-database?tabs=data-factory

These are the permissions for the AdventureWorks2022 database:
  - CREATE USER [<df_name>] FROM EXTERNAL PROVIDER;
  - ALTER ROLE [db_datareader] ADD MEMBER [<df_name>];
  - GRANT SELECT, INSERT, DELETE, UPDATE ON SCHEMA::[Integration] TO [<df_name>];
  - GRANT EXECUTE ON XML SCHEMA COLLECTION::[Person].[IndividualSurveySchemaCollection] TO [<df_name>];

These are the permissions for the AdventureWorksDW2022 database:
  - CREATE USER [<df_name>] FROM EXTERNAL PROVIDER;
  - ALTER ROLE [db_datareader] ADD MEMBER [<df_name>];
  - ALTER ROLE [db_datawriter] ADD MEMBER [<df_name>];
  - GRANT SELECT, INSERT, DELETE, UPDATE ON SCHEMA::[Integration] TO [<df_name>];

Here are the changes:
  - For the OLTP AdventureWorks2022 database
    * Added the following new integration tables.  These are mostly extra tables used for types such as country, day of week, education and etc:
      + Integration.CountryRegion
      + Integration.DayOfWeekType
      + Integration.EducationType
      + Integration.MonthOfYearType
      + Integration.OccupationType
      + Integration.ProductCategoryType
      + Integration.ProductDescriptionType
      + Integration.ProductNameType
      + Integration.ProductSubcategoryType
      + Integration.PromotionCategoryType
      + Integration.PromotionNameType
      + Integration.PromotionType
      + Integration.SizeRangeType
      + Integration.StoreBusinessType
    * Added the Integration schema
  - For DW AdventureWorksDW2022 database
    * Added the following staging and type tables:
       + Integration.CurrencyStaging
       +  Integration.CustomerStaging
       +  Integration.DayOfWeekType
       +  Integration.EmployeeStaging
       +  Integration.FactCurrencyRateStaging
       +  Integration.FactInternetSalesReasonStaging
       +  Integration.FactInternetSalesStaging
       +  Integration.FactResellerSalesStaging
       +  Integration.GeographyStaging
       +  Integration.MonthOfYearType
       +  Integration.ProductCategoryStaging
       +  Integration.ProductStaging
       +  Integration.ProductSubcategoryStaging
       +  Integration.PromotionStaging
       +  Integration.ResellerStaging
       +  Integration.SalesReasonStaging
       +  Integration.SalesTerritoryStaging


