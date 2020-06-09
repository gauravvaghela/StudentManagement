USE [master]
GO
CREATE DATABASE [Interview_StudentManagement_Gaurav]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Interview_StudentManagement_Gaurav', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Interview_StudentManagement_Gaurav.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Interview_StudentManagement_Gaurav_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Interview_StudentManagement_Gaurav_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Interview_StudentManagement_Gaurav].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET ARITHABORT OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET RECOVERY FULL 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET  MULTI_USER 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Interview_StudentManagement_Gaurav', N'ON'
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET QUERY_STORE = OFF
GO
USE [Interview_StudentManagement_Gaurav]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_SplitString]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Vaghela
-- Create date: 09-06-2020
-- Description:	user defined function for split string by special character
-- =============================================
CREATE FUNCTION [dbo].[udf_SplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitdata NVARCHAR(100) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (splitdata)  
        VALUES(LTRIM(RTRIM(SUBSTRING(LTRIM(RTRIM(@string)), @start, @end - @start)))) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)

	END 
    RETURN 
END

GO
/****** Object:  Table [dbo].[Course]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[Course] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourse](
	[StudentCourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
 CONSTRAINT [PK_StudentCourse] PRIMARY KEY CLUSTERED 
(
	[StudentCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteStudent]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Vaghela
-- Create date: 09-06-2020
-- Description:	Stored procedure for delete student
-- =============================================
CREATE PROCEDURE [dbo].[usp_DeleteStudent]
	@StudentId INT
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION

		DELETE FROM Student WHERE StudentId = @StudentId
		DELETE FROM StudentCourse WHERE StudentId = @StudentId

		SELECT @StudentId
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			DECLARE  @ErrorMessage  NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;   

			SELECT @ErrorMessage  = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState    = ERROR_STATE();   
            SET @ErrorMessage=@ErrorMessage   
  
			RAISERROR (@ErrorMessage, @ErrorSeverity,@ErrorState);    
	    END
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetCourseList]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Vaghela
-- Create date: 06-08-2020
-- Description:	Stored Procedure for Get Course List
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetCourseList]	
AS
BEGIN
	SELECT CourseId,Course FROM Course
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetStudentById]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Vaghela
-- Create date: 09-06-2020
-- Description:	Store procedure for get student by studentid
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetStudentById]
	@StudentId INT
AS
BEGIN
	SELECT student.StudentId AS 'StudentId', Name,CONVERT(VARCHAR(10),DateOfBirth,101) AS 'DateOfBirth' , Gender, CourseIDS
	FROM Student student INNER JOIN StudentCourse studentcourse ON student.StudentId = studentcourse.StudentId	
	OUTER APPLY(	
		SELECT STUFF(( SELECT ',' +  CONVERT(VARCHAR(MAX),CourseId) 
		 FROM StudentCourse studentcourse WHERE studentcourse.StudentId = student.StudentId FOR XML PATH ('')), 1, 1, '')
		 )AS StudentcourseIDs(CourseIDS)	
	WHERE student.StudentId = @StudentId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetStudentList]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Vaghela
-- Create date: 09-06-2020
-- Description:	Stored procedure for get student list
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetStudentList]	
AS
BEGIN	
	SELECT StudentId, Name,FORMAT(DateOfBirth,'dd/MM/yyyy') AS DateOfBirth 
	,Gender, DATEDIFF(YY,DateOfBirth,GETDATE()) AS 'Age' FROM Student
	Order by StudentId DESC
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateStudent]    Script Date: 09-06-2020 16:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Vaghela
-- Create date: 09-06-2020
-- Description:	Insert Update Student
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertUpdateStudent]
	@StudentId INT, 
	@Name VARCHAR(100) = '',
	@DateOfBirth VARCHAR(10) = '',
	@Gender VARCHAR(10) = '',
	@CourseIDS VARCHAR(MAX) = ''
AS
BEGIN
BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @tempStudentId INT

			IF ISNULL(@StudentId,0) = 0
			BEGIN
				INSERT INTO Student(Name, DateOfBirth, Gender)
				VALUES(@Name, CONVERT(VARCHAR(10),@DateOfBirth,101), @Gender)

				SET @tempStudentId = SCOPE_IDENTITY();
			END			
			ELSE
			BEGIN
				UPDATE Student SET Name = @Name, DateOfBirth = CONVERT(VARCHAR(10),@DateOfBirth,101), Gender = @Gender
				 WHERE StudentId = @StudentId
				 SET @tempStudentId = @StudentId;
			END

			DELETE FROM StudentCourse WHERE StudentId = @tempStudentId;

			INSERT INTO StudentCourse(CourseId,StudentId)
				SELECT splitdata, @tempStudentId FROM udf_SplitString(@CourseIDS,',')		

	    SELECT @tempStudentId
		COMMIT TRANSACTION
		
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			DECLARE  @ErrorMessage  NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;   

			SELECT @ErrorMessage  = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState    = ERROR_STATE();   
            SET @ErrorMessage=@ErrorMessage   
  
			RAISERROR (@ErrorMessage, @ErrorSeverity,@ErrorState);    
	    END
	END CATCH
END

GO
USE [master]
GO
ALTER DATABASE [Interview_StudentManagement_Gaurav] SET  READ_WRITE 
GO
