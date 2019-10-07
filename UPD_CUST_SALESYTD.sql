if CHECK_WHY_ERROR_1_ISNT_WORKING

DROP PROCEDURE IF EXISTS dbo.UPD_CUST_SALESYTD;

GO
CREATE PROCEDURE UPD_CUST_SALESYTD @pcustid INT, @pamt INT AS
BEGIN TRY
    IF NOT EXISTS(SELECT CUSTID FROM CUSTOMER)
        THROW 50070, 'Customer ID not found', 1
    ELSE
    IF (@pamt < -999.99 OR @pamt > 999.99)
        THROW 50080, 'Amount out of range', 1
    ELSE
    UPDATE CUSTOMER
    SET SALES_YTD = @pamt
    WHERE CUSTID = @pcustid
    
END TRY

BEGIN CATCH
    DECLARE @ErrorMessage AS NVARCHAR(MAX);
    SET @ErrorMessage = ERROR_MESSAGE();

    IF ERROR_NUMBER() = 50070
        THROW 50070, 'Customer ID not found', 1

    ELSE
    IF ERROR_NUMBER() = 50080
        THROW 50080, 'Amount out of range', 1

    ELSE
        THROW 500000, @ErrorMessage, 1

END CATCH

GO
EXEC UPD_CUST_SALESYTD @pcustid = 1, @pamt = 499
 
GO
EXEC UPD_CUST_SALESYTD @pcustid = 123, @pamt = 100

GO
EXEC UPD_CUST_SALESYTD @pcustid = 123, @pamt = 5000

GO
EXEC UPD_CUST_SALESYTD @pcustid = 111, @pamt = 12

GO
SELECT * FROM CUSTOMER;