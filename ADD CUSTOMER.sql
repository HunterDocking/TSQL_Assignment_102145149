DROP PROCEDURE IF EXISTS dbo.ADD_CUSTOMER;

GO
CREATE PROCEDURE ADD_CUSTOMER @pcustid INT, @pcustname NVARCHAR(100) AS
BEGIN
    BEGIN TRY
        IF EXISTS(SELECT * FROM CUSTOMER WHERE CUSTID = @pcustid)
            THROW 50010, 'Duplicate customer ID', 1
        ELSE
        IF (@pcustid < 1 OR @pcustid > 499)
            THROW 50020, 'Customer ID out of range', 1
        ELSE
        INSERT INTO CUSTOMER (CUSTID, CUSTNAME, SALES_YTD, STATUS)
        VALUES (@pcustid, @pcustname, 0, 'OK')
        
    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage AS NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF ERROR_NUMBER() = 50010
            THROW 50010, 'Duplicate customer ID', 1

        ELSE
        IF ERROR_NUMBER() = 50020
            THROW 50020, 'Customer ID out of range', 1

        ELSE
            THROW 500000, @ErrorMessage, 1

    END CATCH
END

GO
EXEC ADD_CUSTOMER @pcustid = 123, @pcustname = Steee

GO
EXEC ADD_CUSTOMER @pcustid = 123, @pcustname = Stiii

GO
EXEC ADD_CUSTOMER @pcustid = 500, @pcustname = Stooo

GO
EXEC ADD_CUSTOMER @pcustid = 1, @pcustname = Staaa

GO
SELECT * FROM CUSTOMER;