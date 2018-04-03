using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.IO;
using Bars.Oracle;

namespace clientregister
{
	public partial class pictureFile : Bars.BarsPage
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			bool showEmptyFile = true;

			if(!String.IsNullOrEmpty(Request.Params.Get("id")))
			{
				int Id = Convert.ToInt32(Request.Params.Get("id"));
				//-- темповая дериктория
				string TempDir = Path.GetTempPath() + "PictureFiles\\";			
				string TempFileName = "img.gif";			
				//-- если дериктории нету, то создаем ее
				DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
				if(!TmpDitInf.Exists) TmpDitInf.Create();

				//-----------------------------------------------------------------
				//-- достаем рисунок
				DataTable dt = new DataTable();
				InitOraConnection(Context);
				try
				{
                    SetRole("WR_CUSTREG");
                
					SetParameters("pId", DB_TYPE.Int32, Id, DIRECTION.Input);
					dt = SQL_SELECT_dataset("SELECT BIN_DATA FROM CUSTOMER_BIN_DATA WHERE ID = :pId").Tables[0];
				}
				finally
				{
					DisposeOraConnection();
				}

				if(dt.Rows.Count > 0)
				{
					showEmptyFile = false;

					byte[] byteData = (byte[])dt.Rows[0].ItemArray[0];

					FileInfo fi = new FileInfo(TempDir + TempFileName);
					FileStream fs = fi.OpenWrite();

					fs.Write(byteData, 0, byteData.Length);
					fs.Close();

					//-----------------------------------------------------------------
					//-- брасаем в поток
					Response.Clear();
					Response.ContentType = "application/octet-stream";
					Response.AppendHeader("Cache-control", "private");
					Response.AppendHeader("Content-Location", TempDir + TempFileName);
					Response.AppendHeader("Location", TempDir + TempFileName);

					Response.AddHeader("Content-Disposition","attachment;filename=" + TempFileName);
					Response.Flush();
					Response.WriteFile(TempDir + TempFileName);
					Response.End();

					//-----------------------------------------------------------------
					//-- удаляем файл
					fi.Delete();
				}
				else
				{
					showEmptyFile = true;
				}
			}

			if(showEmptyFile)
			{
				string TempDir = Path.GetTempPath() + "PictureFiles\\";			
				string TempFileName = "img.gif";			
				//-- если дериктории нету, то создаем ее
				DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
				if(!TmpDitInf.Exists) TmpDitInf.Create();

				//-----------------------------------------------------------------
				//-- формируем файл
				Bitmap bmp= new Bitmap(150, 150);
				System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmp);

				StringFormat st = new StringFormat();
				st.Alignment = StringAlignment.Center;

				//g.DrawString("Нет файла!", new Font("Arial", 20), new SolidBrush(Color.Black), new RectangleF(new PointF(0,0), new SizeF(150,150)), st);
				g.DrawLine(new Pen(Color.Black, 2), new Point(0,0), new Point(150,150));
				g.DrawLine(new Pen(Color.Black, 2), new Point(0,150), new Point(150,0));

				bmp.Save(TempDir + TempFileName);

				FileInfo fi = new FileInfo(TempDir + TempFileName);

				//-----------------------------------------------------------------
				//-- брасаем в поток
				Response.Clear();
				Response.ContentType = "application/octet-stream";
				Response.AppendHeader("Cache-control", "private");
				Response.AppendHeader("Content-Location", TempDir + TempFileName);
				Response.AppendHeader("Location", TempDir + TempFileName);

				Response.AddHeader("Content-Disposition","attachment;filename=" + TempFileName);
				Response.Flush();
				Response.WriteFile(TempDir + TempFileName);
				Response.End();

				//-----------------------------------------------------------------
				//-- удаляем файл
				fi.Delete();
			}
		}
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
		}
		#endregion
	}
}
