/*
MSSQL:
print 2&3&5&7 .... &997
*/
DECLARE @i int=2;
DECLARE @prime int = 0;
DECLARE @result nvarchar(1000) = ''; --CAN BE ADJUSTED
WHILE (@i<=1000)
BEGIN
   DECLARE @j int = @i-1;
   SET @prime = 1;
   WHILE(@j > 1)
   BEGIN
      IF @i % @j = 0
      BEGIN 
         SET @prime = 0;
      END
    SET @j = @j - 1;
   END
   IF @prime = 1
   BEGIN
      set @result += CAST(@i AS nvarchar(1000)) + '&';
   END
SET @i = @i + 1;
END
SET @result = SUBSTRING(@result, 1, LEN(@result) - 1)
SELECT @result
