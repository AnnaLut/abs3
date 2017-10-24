using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Doc.Models;
using BarsWeb.Areas.DepoFiles.Models;

namespace BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Abstract
{
    public interface IDepoFilesRepository
    {
        IEnumerable<AcceptedFiles> GetAcceptedFiles();
        decimal Copy(decimal? header_id);
        void Delete(decimal? header_id);
        string GetStatistics(decimal header_id);
        void MarkLine(decimal info_id, decimal mark);
        IEnumerable<ShowFile> GetShowFile(decimal? header_id);
        List<DropDown> LoadAgencyTypes();
        List<DropDown> LoadAgencyInGb(int agency_type);
        List<DropDown> LoadFileTypes();
        List<AccDropDown> LoadAccTypes();
        List<AccDropDown> LoadBranchTypes();
        object GetDropDownValues(decimal header_id);
        IEnumerable<GridBranch> GetGridBranch(decimal? header_id);
        List<DropDown> GetSocAgency(string branch, int agency_type);
        void UpdateGridBranch(decimal header_id, string branch, int agency_id);
        string GetUFilename();
        string InsertHeader(AcceptedFiles obj);
        FileHeaderModel GetFileHeader(string str);
        FileHeaderModel GetFileHeader(string filename, DateTime dat, string header_id);
        ShowFile GetFileInfo(int str_num, string str, int month, int year);
        List<ShowFile> GetFileInfo(string header_id);
        decimal WriteToDatabaseExt(bool setupAgencies, FileHeaderModel header, List<ShowFile> info, decimal type_id, decimal agency_type, string Acc_Type);
        decimal[] GetParams(string header_id);
        void PayGb(decimal agency_id, decimal header_id, decimal type_id);
        void Pay(decimal header_id, decimal type_id);
        List<DepositBfRow> GetDepositBfRowCorrection(decimal info_id);
        void UpdateRow(UpdateModel model);
        void InsertFileGrid(dynamic row);
        void Finish(decimal header_id);
        void DeleteRow(decimal info_id);
    }
}