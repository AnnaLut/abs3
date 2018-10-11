using System;
using System.IO;
using System.Web;
using System.Text;
using Bars.Classes;
using System.Web.SessionState;

namespace Bars.Web.Print
{
	/// <summary>
	/// Сторінка, де завантажується
	/// текст
	/// </summary>
	public class BarsPage: IHttpHandler, IRequiresSessionState 
	{
		public BarsPage(){}
		bool IHttpHandler.IsReusable { get{return true;} }
        /// <summary>
        /// Обробка запиту на друк документа
        /// </summary>
        /// <param name="context">поточний контекст</param>
		void IHttpHandler.ProcessRequest(HttpContext context)
		{            
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            String filename = String.Empty;

            /// Створюємо файл траси, якщо передали відповідний параметр
            FileStream traceFile = null;
            StreamWriter trace = null;
            if (Convert.ToString(Request["trace"]) == "true")
            {
                if (File.Exists(Path.GetTempPath() + "trace.txt"))
                    traceFile = new FileStream(Path.GetTempPath() + "trace.txt", FileMode.Append);
                else
                    traceFile = new FileStream(Path.GetTempPath() + "trace.txt", FileMode.OpenOrCreate);

                trace = new StreamWriter(traceFile);
                trace.WriteLine("Дата:" + DateTime.Now.ToString());
            }
            
            if (trace != null) trace.WriteLine("Виклик: " + Request.Url);

            Response.ClearContent();
            Response.ClearHeaders();

            try
            {
                /// Друк звітів
                if (Request["filename"] != null)
                {
                    filename = Convert.ToString(Request["filename"]);
                    string fileExtention = Path.GetExtension(filename).ToLower();
                    string mimeType = MimeTypeMap.GetMimeType(fileExtention);
                    bool isRtf = (fileExtention == ".rtf") ? (true) : (false);
                    bool isPdf = (fileExtention == ".pdf") ? (true) : (false);
                    bool idDocx = (fileExtention == ".doc") ? (true) : (false);

                    bool isDefault = !isRtf && !isPdf && !idDocx;

                    Response.Charset = "windows-1251";
                    Response.ContentEncoding = Encoding.GetEncoding(Response.Charset);
                    //Response.ContentEncoding = Encoding.UTF8;
                    if (!isDefault)
                    {
                        if (Request["attach"] != null)
                        {
                            PrintRtfFile(filename, context, trace);
                            return;
                        }
                        //Response.AddHeader("Content-Disposition", "inline;filename=Contract"+fileExtention);
                        if (!isRtf)
                        {
                            Response.AddHeader("Content-Disposition", "attachment;filename=Contract" + fileExtention);
                            Response.ContentType = mimeType;
                        }
                        else
                        {
                            Response.AddHeader("Content-Disposition", "inline;filename=Contract.rtf");
                            Response.ContentType = "application/octet-stream";
                        }
                    }
                    else
                    {
                        //if we need to show text before downloading - change charset to next - proper one:
                        //Response.Charset = "utf-8";
                        //Response.ContentEncoding = Encoding.UTF8;
                        if (Request["frxConvertedTxt"] != null)
                        {
                            Response.AddHeader("Content-Disposition", "attachment;filename=Report.txt");
                        }
                        else
                        {
                            Response.AddHeader("Content-Disposition", "inline;filename=Report.txt");
                        }
                        Response.ContentType = "text/html";
                    }

                    if (isDefault) Response.Write("<PRE>");
                    Response.WriteFile(filename, true);

                    if (isDefault) Response.Write("</PRE>");

                    // Response.Flush();
                }
                /// 
                else if (Request["nd"] != null && Request["template"] != null && Request["adds"] != null)
                {
                    if (trace != null)
                        trace.WriteLine("Друк договору. dpt_id = " + Convert.ToString(Request["nd"])
                            + ", template=" + Convert.ToString(Request["template"])
                            + ", adds=" + Convert.ToString(Request["adds"]));

                    String template = Convert.ToString(Request["template"]);
                    Decimal nd = Convert.ToDecimal(Convert.ToString(Request["nd"]));
                    Decimal adds = Convert.ToDecimal(Convert.ToString(Request["adds"]));

                    Bars.Classes.BarsPrintClass printer = new BarsPrintClass();
                    filename = printer.CreateSkrFile(nd, template, adds);

                    PrintRtfFile(filename, context, trace);                    
                }
                /// Друк соц. депозитних договорів, договорів по технічних рахунках
                else if (Request["dpt_id"] != null && Request["template"] != null)
                {
                    if (trace != null)
                        trace.WriteLine("Друк договору. dpt_id = " + Convert.ToString(Request["dpt_id"])
                            + ", template=" + Convert.ToString(Request["template"]));

                    String template = Convert.ToString(Request["template"]);
                    Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

                    Bars.Classes.BarsPrintClass printer = new BarsPrintClass();
                    filename = printer.CreateDptContractFile(dpt_id, template);

                    PrintHtmlFile(filename, context, trace);
                }
                /// Друк анкет та інших html чи mht файлів
                else if (Request["mht_file"] != null)
                {
                    filename = Convert.ToString(Request["mht_file"]);

                    if (trace != null) trace.WriteLine("Друк файлу " + filename);

                    PrintHtmlFile(filename, context, trace);
                }
            }
            catch (System.Exception ex)
            {
                if (trace != null)
                {
                    trace.WriteLine("Виникла помилка:");
                    trace.WriteLine(ex.Message);
                    trace.WriteLine(ex.StackTrace);
                }
                throw ex;                
            }
            finally
            {
                ///// Видаляємо файл, що прийшов до нас
                //if (trace != null) trace.WriteLine("Видаляємо файл " + filename);
                //try {File.Delete(filename); } catch { }
                /// Закриваємо файл, куди писалась траса                
                if (trace != null) { trace.Close(); traceFile.Close(); }
                Response.Flush();
                
            }
		}
        /// <summary>
        /// Друк файлів
        /// </summary>
        /// <param name="filename">Імя файлу</param>
        /// <param name="context">поточний контекст</param>
        /// <param name="trace">Файл для траси. Якщо відключена - null</param>
        private void PrintHtmlFile(String filename, HttpContext context, StreamWriter trace)
        {           
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            
            FileStream file = new FileStream(filename, FileMode.Open);
            StreamReader streamRead = new StreamReader(file);
            String str_mht = streamRead.ReadToEnd();
            streamRead.Close();
            file.Close();

            if (str_mht.Substring(0, 4) == "MIME")
            {
                if (trace != null) trace.WriteLine("Тип файлу - mht");
                file = new FileStream(filename, FileMode.Create, FileAccess.Write);
                StreamWriter streamWriter = new StreamWriter(file);
                /// Додаємо скріпт який блокує виділення мишкою та контекстне меню
                /// по замовчуванню експлорер це дозволяє, якщо завантажено
                /// mht файл, навіть в модальному вікні
                String script = "<script language=3D'JavaScript'> " +
                    "document.ondragstart =3D sec_mess; " +
                    "document.onselectstart =3D sec_mess; " +
                    "document.oncontextmenu =3D sec_mess; " +
                    "function sec_mess() { return false; } " +
                "</script>";

                String new_str_mht = str_mht.Insert(str_mht.IndexOf("</body>"), script);

                streamWriter.Write(new_str_mht);
                streamWriter.Flush();
                streamWriter.Close();
                file.Close();

                Response.ContentType = "multipart/related"; // multipart/related or message/rfc822
                Response.AddHeader("Content-Disposition", "inline;filename=contract.mht");
            }
            else
            {                
                if (trace != null) trace.WriteLine("Тип файлу - html");
                Response.ContentType = "text/html";
                Response.AddHeader("Content-Disposition", "inline;filename=contract.html");
            }

            /// Пишемо трасу
            if (trace != null)
            {
                trace.WriteLine("Response.Charset = " + Response.Charset);
                trace.WriteLine("Response.ContentEncoding.WindowsCodePage = " + Response.ContentEncoding.WindowsCodePage);
                trace.WriteLine("Response.ContentEncoding.EncodingName = " + Response.ContentEncoding.EncodingName);
                trace.WriteLine("Response.ContentEncoding.CodePage = " + Response.ContentEncoding.CodePage);
            }

            /// Обовязково другий параметр має бути true
            /// інакше неможливо видалити файл
            Response.WriteFile(filename, true);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="context"></param>
        /// <param name="trace"></param>
        private void PrintRtfFile(String filename, HttpContext context, StreamWriter trace)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;

            Response.AddHeader("Content-Disposition", "attachment;filename=contract.rtf");
            Response.ContentType = "application/octet-stream";

            /// Обовязково другий параметр має бути true
            /// інакше неможливо видалити файл
            Response.WriteFile(filename, true);
        }
        /// <summary>
        /// НЕ ВИКОРИСТОВУЄТЬСЯ
        /// </summary>
        /// <param name="fileText">Документа</param>
        /// <param name="mht">true - mht, false - html</param>
        /// <returns>Потрібний Response.CharSet</returns>
        private String GetCharSet(String fileText, bool mht, StreamWriter trace)
        {
            throw new ApplicationException("Не потрібно використовувати цей метод!");

            String CharSet = String.Empty;
            if (mht)
            {
                ;
            }
            /// Кажемо, що це html
            else
            {
                /// Шукаємо таг mega
                int m_start = fileText.IndexOf("<meta");
                int m_end = fileText.IndexOf(">",m_start);
                if (m_start<0 || m_end<0)
                    throw new IOException("Некоректний формат файлу. У файлі відсутній тег meta!");

                String meta = fileText.Substring(m_start,m_end - m_start + 1);

                if (trace != null) trace.WriteLine("meta = " + meta);
                
                m_start = meta.IndexOf("charset=") + 8;                               
                m_end = meta.IndexOf("\"", m_start);

                if (trace != null) trace.WriteLine("m_start = " + m_start.ToString());                
                if (trace != null) trace.WriteLine("m_end = " + m_end.ToString());
                
                if (m_start < 0 || m_end < 0 || meta.Length - m_end <= 0)
                    throw new IOException("Неможливо визначити CharSet одержаного файлу!");

                CharSet = meta.Substring(m_start, m_end - m_start);

                if (trace != null) trace.WriteLine("CharSet = " + CharSet);
            }

            return CharSet;
        }
	}
}
