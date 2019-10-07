-- if CHECK_WHY_ERROR_1_ISNT_WORKING
-- if CHECK_WHY_ERROR_2_TYPE_CHECK_ISNT_WORKING

DROP PROCEDURE IF EXISTS dbo.UPD_CUSTOMER_STATUS;

GO
CREATE PROCEDURE UPD_CUSTOMER_STATUS @pcustid INT, @pstatus NVARCHAR AS
BEGIN TRY
    IF (@pcustid = NULL)
        THROW 50120, 'Customer ID not found', 1
    ELSE
    -- IF (@pstatus != 'OK' OR @pstatus != 'SUSPEND')
    --     THROW 50130, 'Invalid Status Value', 1
    -- ELSE
    UPDATE CUSTOMER
    SET STATUS = @pstatus
    WHERE @pstatus = 'OK' OR @pstatus = 'SUSPEND'
    
END TRY

BEGIN CATCH
    DECLARE @ErrorMessage AS NVARCHAR(MAX);
    SET @ErrorMessage = ERROR_MESSAGE();

    IF ERROR_NUMBER() = 50070
        THROW 50120, 'Customer ID not found', 1

    ELSE
    IF ERROR_NUMBER() = 50080
        THROW 50130, 'Invalid Status Value', 1

    ELSE
        THROW 500000, @ErrorMessage, 1

END CATCH

GO
EXEC UPD_CUSTOMER_STATUS @pcustid = 1, @pstatus = 'OK'
 
GO
EXEC UPD_CUSTOMER_STATUS @pcustid = 123, @pstatus = 'SUSPEND'

GO
EXEC UPD_CUSTOMER_STATUS @pcustid = 123, @pstatus = 'YEAHNAH'

GO
EXEC UPD_CUSTOMER_STATUS @pcustid = 123, @pstatus = 12

GO
EXEC UPD_CUSTOMER_STATUS @pcustid = 111, @pstatus = 'OK'

GO
SELECT * FROM CUSTOMER;