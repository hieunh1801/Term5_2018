-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_DanhMucChuyenNganh_Update
	@ma_chuyen_nganh int,
	@ten_chuyen_nganh nvarchar(200),
	@ghi_chu nvarchar(200)
AS
BEGIN
	update danh_muc_chuyen_nganh
	set ten_chuyen_nganh = @ten_chuyen_nganh,
		ghi_chu = @ghi_chu
	where @ma_chuyen_nganh = ma_chuyen_nganh
END
GO
