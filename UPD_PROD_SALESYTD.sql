if CHECK_WHY_ERROR_1_ISNT_WORKING

DROP PROCEDURE IF EXISTS dbo.UPD_PROD_SALESYTD;

GO
CREATE PROCEDURE UPD_PROD_SALESYTD @pprodid INT, @pamt INT AS
BEGIN TRY
    IF NOT EXISTS(SELECT PRODID FROM PRODUCT)
        THROW 50100, 'Product ID not found', 1
    ELSE
    IF (@pamt < -999.99 OR @pamt > 999.99)
        THROW 50110, 'Amount out of range', 1
    ELSE
    UPDATE PRODUCT
    SET SALES_YTD = @pamt
    WHERE PRODID = @pprodid
    
END TRY

BEGIN CATCH
    DECLARE @ErrorMessage AS NVARCHAR(MAX);
    SET @ErrorMessage = ERROR_MESSAGE();

    IF ERROR_NUMBER() = 50070
        THROW 50100, 'Product ID not found', 1

    ELSE
    IF ERROR_NUMBER() = 50080
        THROW 50110, 'Amount out of range', 1

    ELSE
        THROW 500000, @ErrorMessage, 1

END CATCH

GO
EXEC UPD_PROD_SALESYTD @pprodid = 1230, @pamt = 499
 
GO
EXEC UPD_PROD_SALESYTD @pprodid = 2500, @pamt = 100

GO
EXEC UPD_PROD_SALESYTD @pprodid = 2500, @pamt = 5000

GO
EXEC UPD_PROD_SALESYTD @pprodid = 111, @pamt = 12

GO
SELECT * FROM PRODUCT;