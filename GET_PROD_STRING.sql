IF ELSE NULL FIXERROR1

DROP PROCEDURE IF EXISTS dbo.GET_PROD_STRING;

GO
CREATE PROCEDURE GET_PROD_STRING @pprodid INT AS
BEGIN
    BEGIN TRY
        DECLARE @pReturnString NVARCHAR(1000)
        SELECT @pReturnString = CONCAT('Prodid: ', PRODID, '  Name:', PRODNAME, '  Price ', SELLING_PRICE, '  SalesYTD:', SALES_YTD)
        FROM PRODUCT
        WHERE (PRODID = @pprodid)   
        SELECT @pReturnString
    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage AS NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF ERROR_NUMBER() = 50070
            THROW 50120, 'Product ID not found', 1;
    END CATCH;
END;

GO
EXEC GET_PROD_STRING @pprodid = 1;

EXEC GET_PROD_STRING @pprodid = 500;

select * from PRODUCT;