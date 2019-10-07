-- if CHECK_WHY_ERROR_3_ISNT_WORKING
-- if CHECK_WHY_ERROR_4_TYPE_CHECK_ISNT_WORKING
-- if Calls UPD_CUST_SALES_YTD_IN_DB 
-- if Calls UPD_PROD_SALES_YTD_IN_DB

DROP PROCEDURE IF EXISTS dbo.ADD_SIMPLE_SALE;

GO
CREATE PROCEDURE ADD_SIMPLE_SALE @pcustid INT, @pprodid INT, @pqty INT AS

BEGIN
    BEGIN TRY
        IF (@pqty < 1 OR @pqty > 999)
            THROW 50140, 'Sale Quantity outside valid range', 1
        ELSE
        -- IF (STATUS != 'OK')
        --     THROW 50150, 'Customer status is not OK', 1
        -- ELSE
        IF NOT EXISTS(SELECT CUSTID FROM CUSTOMER)
            THROW 50160, 'Customer ID not found', 1
        ELSE
        IF NOT EXISTS(SELECT PRODID FROM PRODUCT)
            THROW 50170, 'Product ID not found', 1
        ELSE
        INSERT INTO SALE (CUSTID, PRODID, QTY)
        VALUES (@pcustid, @pprodid, @pqty)
    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage AS NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF ERROR_NUMBER() = 50070
            THROW 50140, 'Sale Quantity outside valid range', 1

        ELSE
        IF ERROR_NUMBER() = 50150
            THROW 50150, 'Customer status is not OK', 1

        ELSE
        IF ERROR_NUMBER() = 50160
            THROW 50160, 'Customer ID not found', 1

        ELSE
        IF ERROR_NUMBER() = 50170
            THROW 50170, 'Product ID not found', 1
        
        ELSE
            THROW 500000, @ErrorMessage, 1
            
    END CATCH
END

GO
EXEC ADD_SIMPLE_SALE @pcustid = 1, @pprodid = 1230, @pqty = 5
 
-- GO
-- EXEC ADD_SIMPLE_SALE @pcustid = 123, @

-- GO
-- EXEC ADD_SIMPLE_SALE @pcustid = 123, @

-- GO
-- EXEC ADD_SIMPLE_SALE @pcustid = 123, @

-- GO
-- EXEC ADD_SIMPLE_SALE @pcustid = 111, @

GO
SELECT * FROM CUSTOMER;