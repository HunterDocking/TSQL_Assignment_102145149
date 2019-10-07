DROP PROCEDURE IF EXISTS dbo.DELETE_ALL_SALES;

GO
CREATE PROCEDURE DELETE_ALL_SALES AS

BEGIN
    BEGIN TRY
        DELETE FROM SALE

        SELECT @@ROWCOUNT AS "Rows Deleted"
    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage AS NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();
            THROW 500000, @ErrorMessage, 1
    END CATCH
END

GO
EXEC DELETE_ALL_SALES;
