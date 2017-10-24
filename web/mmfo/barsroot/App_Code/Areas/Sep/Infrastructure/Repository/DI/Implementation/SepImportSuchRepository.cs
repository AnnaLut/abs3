using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using DotNetDBF;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using Areas.Sep.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;


public class SepImportSuchRepository : ISepImportSuchRepository
{

    private readonly SepFiles _entities;

	public SepImportSuchRepository()
	{
        var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
        _entities = new SepFiles(connectionStr);
	}

    public void Import(bool recode, string path)
    {
        string _path = path + "\\S_UCH.DBF";
        DBFReader file = new DBFReader(_path);
                
        int NumberOfrecords = file.RecordCount;
        BanksRepository banks = new BanksRepository();
        string ourMfo = banks.GetOurMfo();        

        object[] updateParameter = { new OracleParameter ("p_ourmfo", OracleDbType.Varchar2) {Value = ourMfo} };

        _entities.ExecuteStoreCommand(@"UPDATE banks SET blk=4 WHERE mfop<>:p_ourmfo", updateParameter);
        
        DateTime Date = DateTime.Now;
        
        string sFn = "$UXXXX" + Sep98md(Date) + ".000";

        object[] InsertParameters = 
        {
            new OracleParameter ("sFn", OracleDbType.Varchar2) {Value = sFn},
            new OracleParameter ("dDat", OracleDbType.Date) {Value = Date},
            new OracleParameter ("nHdr", OracleDbType.Decimal) {Value = NumberOfrecords}
        };
        
        _entities.ExecuteStoreCommand(@"INSERT INTO banks_update_hdr (fn,dat,n,rec_start,rec_finish,acc1,acc2)
                                        VALUES (:sFn,:dDat,:nHdr,:nHdr,:nHdr,:nHdr,:nHdr)", InsertParameters);
        
        for (int i = 0; i < NumberOfrecords; i++)
        {
            Object[] objects = file.NextRecord(true);
            string BankName = (string)objects[3];

            if (recode)
            {
                Encoding src = Encoding.GetEncoding(866);
                Encoding trg = Encoding.GetEncoding(1251);

                BankName = Recoding(BankName, src, trg);
            }

            object[] BankUpdateParams = 
            {
                new OracleParameter ("j", OracleDbType.Int32) {Value = i + 1},
                new OracleParameter ("nMfo", OracleDbType.Int32) {Value = objects[0]},
                new OracleParameter ("sNb", OracleDbType.NVarchar2) {Value = objects[3]},
                new OracleParameter ("sNbw", OracleDbType.NVarchar2) {Value = BankName},
                new OracleParameter ("sSab", OracleDbType.NVarchar2) {Value = objects[1]},
                new OracleParameter ("sSab_p", OracleDbType.NVarchar2) {Value = objects[2]},
                new OracleParameter ("sMod", OracleDbType.NVarchar2) {Value = objects[5]},
                new OracleParameter ("sMdl", OracleDbType.NVarchar2) {Value = objects[4]},
                new OracleParameter ("nMfop", OracleDbType.Int32) {Value = objects[6]},
                new OracleParameter ("nMfou", OracleDbType.Int32) {Value = objects[7]}
            };

            _entities.ExecuteStoreCommand(@"INSERT INTO banks_update (ord,header,op,mfo,nb,nbw,sab,sabp,model,model_no,mfop,mfou,kv,gate,blk,arm2)   
                                                    VALUES (:j,s_Banks_update_hdr.nextval,'A',:nMfo,:sNb,:sNbw,:sSab,:sSab_p,:sMod,:sMdl,:nMfop,:nMfou,980,null,null,' ')", BankUpdateParams);

        }
    }
    
    private string Recoding(string value, Encoding src, Encoding trg)
    {
        byte[] srcBytes = src.GetBytes(value);
        byte[] dstBytes = Encoding.Convert(src, trg, srcBytes);
        return trg.GetString(dstBytes);
    }


    private string Sep98md(DateTime today)
    {
        int month = (int)today.Month;
        int day = (int)today.Day;
        if (month < 10)
        {
            month += 48;
        }
        else
        {
            month += 55;
        }
        if (day < 10)
        {
            day += 48;
        }
        else
        {
            day += 55;
        }
        char monthCode = (char)month;
        char dayCode = (char)day;
        return monthCode.ToString() + dayCode.ToString();
    }

}