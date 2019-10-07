DROP PROCEDURE IF EXISTS dbo.ADD_PRODUCT;

GO
CREATE PROCEDURE ADD_PRODUCT @pprodid INT, @pprodname NVARCHAR(100), @pprice MONEY AS
BEGIN
    BEGIN TRY
        IF EXISTS(SELECT * FROM PRODUCT WHERE PRODID = @pprodid)
            THROW 50030, 'Duplicate product ID', 1
        ELSE
        IF (@pprodid < 1000 OR @pprodid > 2500)
            THROW 50040, 'Product ID out of range', 1
        ELSE
        IF (@pprice < 0 OR @pprice > 999.99)
            THROW 50050, 'Price out of range', 1
        ELSE
        INSERT INTO PRODUCT (PRODID, PRODNAME, SELLING_PRICE, SALES_YTD)
        VALUES (@pprodid, @pprodname, @pprice, 0)
        
    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage AS NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF ERROR_NUMBER() = 50010
            THROW 50030, 'Duplicate product ID', 1

        ELSE
        IF ERROR_NUMBER() = 50020
            THROW 50040, 'Product ID out of range', 1

        ELSE
        IF ERROR_NUMBER() = 50020
            THROW 50050, 'Price out of range', 1

        ELSE
            THROW 500000, @ErrorMessage, 1

    END CATCH
END

GO
EXEC ADD_PRODUCT @pprodid = 1230, @pprodname = t1, @pprice = 0

GO
EXEC ADD_PRODUCT @pprodid = 1230, @pprodname = t2, @pprice = 666.66

GO
EXEC ADD_PRODUCT @pprodid = 2500, @pprodname = t3, @pprice = 12.50

GO
EXEC ADD_PRODUCT @pprodid = 1, @pprodname = t4, @pprice = 1000

GO
EXEC ADD_PRODUCT @pprodid = 1000, @pprodname = t4, @pprice = 1000

GO
SELECT * FROM PRODUCT;