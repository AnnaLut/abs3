using BarsWeb.Areas.Dpa.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Dpa.Infrastructure.Repository.DI.Abstract
{
    public interface IRegisterCountsDPARepository
    {
        List<T> GetFileReport<T>(string entereddate, string fileType);
        object UploadGrid(dynamic grid, string fileType, string entereddate);
        string GetFileName(string fileType);
        List<FileResponse> GetList(string fileType, string entereddate);
        List<AllFiles> GetAllFiles(string fileType);
        void DeleteRows(dynamic rows, string fileType);
        string ProcessFilesDPA(string fileName, string path);
        void InsertTicket(string path, string fileType, string fileName, string fileBody);
        List<CodesF2> GetCodesF2(string fileName);
        List<F2Arc> GetF2Archive();
        List<F2Arc> GetK2Archive();
        List<F2Grid> GetF2Grid(string fileName);
        List<K0Grid> GetK2Grid(string fileName);
        void DeleteFile(string fileName, string path);
        List<T> GetFormedFilesF0Grid<T>(string file_type);
        List<T> GetF0Grid<T>(string fileName);
        List<R0Arc> GetR0Archive();
        List<R0Grid> GetR0Grid(string fileName);
        void FormF0Files(string file_name, List<F0Grid> grid);
        PrintHeader GetPrintHeader();
        string GetBranch();
        DateTime GetBankDate();
        List<KVModel> GetKVs();
        List<KVModel> GetCountries();
    }
}