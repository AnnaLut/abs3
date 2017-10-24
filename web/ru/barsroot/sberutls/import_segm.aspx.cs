using System;
using System.Text;
using System.Collections.Generic;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Data;
using System.Globalization;
using System.Dynamic;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json;

public partial class sberutls_import_segm : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class Strucrure
    {
        public string rnk { get; set; }
        public string s1 { get; set; }

        public string s2 { get; set; }
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        divMsg.InnerText = String.Empty;
        divMsgOk.InnerText = String.Empty;


        String Result = String.Empty;



        if (fileUpload.PostedFile.FileName == String.Empty || fileUpload.PostedFile.ContentLength == 0)
        {
            divMsg.InnerText = "Файл не вибрано";
            return;
        }
        byte[] data = new byte[fileUpload.PostedFile.ContentLength];
        fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        fileUpload.PostedFile.InputStream.Close();
        String InputBuffer = Encoding.GetEncoding(1251).GetString(data);

        List<Strucrure> text = JsonConvert.DeserializeObject<List<Strucrure>>(InputBuffer);
        InitOraConnection();
        try
        {
            for (var i = 0; i < text.Count; i++)
            {

                string rnk = text[i].rnk;
                string s1 = text[i].s1;
                string s2 = text[i].s2;

                ClearParameters();
                SetParameters("bussl", DB_TYPE.Varchar2, s1, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Varchar2, rnk, DIRECTION.Input);
                SetParameters("rnk2", DB_TYPE.Varchar2, rnk, DIRECTION.Input);
                SetParameters("bussl2", DB_TYPE.Varchar2, s1, DIRECTION.Input);
                SetParameters("busss", DB_TYPE.Varchar2, s2, DIRECTION.Input);
                SetParameters("rnk3", DB_TYPE.Varchar2, rnk, DIRECTION.Input);
                SetParameters("rnk4", DB_TYPE.Varchar2, rnk, DIRECTION.Input);
                SetParameters("busss2", DB_TYPE.Varchar2, s2, DIRECTION.Input);

                SQL_NONQUERY(@"begin
                                begin
                                    update customerw
                                        set value = :bussl
                                        where rnk=:rnk and tag='BUSSL';
                                      if sql%rowcount=0 then
                                        insert into customerw(rnk, tag, value, isp)
                                            values(:rnk2, 'BUSSL', :bussl2, 0);
                                        end if;  
                                    end;
                                begin
                                    update customerw
                                        set value = :busss
                                        where rnk=:rnk3 and tag='BUSSS';
                                      if sql%rowcount=0 then
                                        insert into customerw(rnk, tag, value, isp)
                                            values(:rnk4, 'BUSSS', :busss2, 0);
                                        end if;  
                                    end;

                                end;");


            }
        }
        catch(Exception ex)
        {
            Result = ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }



        if ((String.IsNullOrEmpty(Result)) || Result == "null")
        {
            divMsgOk.InnerText = "Імпорт виконано без помилок";
        }
        else
        {
            divMsg.InnerText = Result;
        }
    }
}