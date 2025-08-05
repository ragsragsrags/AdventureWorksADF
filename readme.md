Initialized by Azure Data Factory!This is an ETL workflow on OLTP Adventureworks database to a warehouse database for Azure Data Factory.  This is only the sales data (finance data is not included) and one-time only. This is to assume you have azure subscription.  Here are some relevant documents:

Create server/database: https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql&tabs=azure-portal
Connect to server: https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-ssms?view=azuresql

I'm using the 2022 version of the database sample: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

![image](https://github.com/user-attachments/assets/412ab68b-9456-431d-b369-60cdc8fe64af)

Restore the backup db first in the local sql server.  Run the updates: AdventureWorks2022_Updates.sql

Then, I've deployed it to the Azure Data Factory using this step: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

<img width="876" height="837" alt="image" src="https://github.com/user-attachments/assets/f7fbe3a8-5e40-47b3-8a8d-2c2a1250d14d" />


For the datawarehouse database, run this script to the local server and deploy to azure using the steps above: AdventureWorksDW2022_Database.sql 

Also, you need to properly connect to the azure sql server.  I'm using this document: https://learn.microsoft.com/en-us/azure/data-factory/connector-azure-sql-database?tabs=data-factory

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


