IF ELSE NULL FIXERROR1

DROP PROCEDURE IF EXISTS dbo.GET_CUSTOMER_STRING;

GO
CREATE PROCEDURE GET_CUSTOMER_STRING @pcustid INT AS
BEGIN
    BEGIN TRY
        DECLARE @pReturnString NVARCHAR(1000)
        SELECT @pReturnString = CONCAT('Custid: ', CUSTID, '  Name:', CUSTNAME, '  Status ', STATUS, '  SalesYTD:', SALES_YTD)
        FROM CUSTOMER
        WHERE (CUSTID = @pcustid)
        SELECT @pReturnString
    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage AS NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF ERROR_NUMBER() = 50070
            THROW 50120, 'Customer ID not found', 1;
    END CATCH;
END;

GO
EXEC GET_CUSTOMER_STRING @pcustid = 1;

EXEC GET_CUSTOMER_STRING @pcustid = 500;

select * from CUSTOMER;