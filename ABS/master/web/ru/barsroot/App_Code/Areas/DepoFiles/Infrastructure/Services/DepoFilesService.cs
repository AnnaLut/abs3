using BarsWeb.Areas.DepoFiles.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.DepoFiles.Services
{
    public class DepoFilesService
    {
        public DepoFilesService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public void TrimNls(List<ShowFile> info)
        {
            for (int i = 0; i < info.Count; i++)
            {
                info[i].NLS = info[i].NLS.Trim();

                String tmp = info[i].NLS.TrimStart('0');

                if (tmp == String.Empty)
                    continue;

                if (tmp.Length == 9)
                    info[i].NLS = "0" + tmp;
                else
                    info[i].NLS = tmp;
            }
        }

        public Decimal[] get_header_id(List<ShowFile> info, decimal header_id)
        {
            Decimal[] result = new Decimal[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = header_id;

            return result;
        }
        public String[] get_filename(List<ShowFile> info, FileHeaderModel header)
        {
            String[] result = new String[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = header.filename;

            return result;
        }
        public int[] get_filename_size(List<ShowFile> info, FileHeaderModel header)
        {
            int[] result = new int[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = header.filename.Length;

            return result;
        }
        public DateTime[] get_dat(List<ShowFile> info, FileHeaderModel header)
        {
            DateTime[] result = new DateTime[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = header.dtCreated;

            return result;
        }
        public String[] get_nls(List<ShowFile> info)
        {
            String[] result = new String[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].NLS;

            return result;
        }
        public int[] get_nls_size(List<ShowFile> info)
        {
            int[] result = new int[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].NLS.Length;

            return result;
        }
        public Decimal[] get_branch_code(List<ShowFile> info)
        {
            Decimal[] result = new Decimal[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].BRANCH_CODE;

            return result;
        }
        public Decimal[] get_dpt_code(List<ShowFile> info)
        {
            Decimal[] result = new Decimal[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].DPT_CODE;

            return result;
        }
        public Decimal[] get_sum(List<ShowFile> info)
        {
            Decimal[] result = new Decimal[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = Convert.ToDecimal(info[i].SUM);

            return result;
        }
        public String[] get_fio(List<ShowFile> info)
        {
            String[] result = new String[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].FIO;

            return result;
        }
        public int[] get_fio_size(List<ShowFile> info)
        {
            int[] result = new int[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].FIO.Length;

            return result;
        }
        public String[] get_id_code(List<ShowFile> info)
        {
            String[] result = new String[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].ID_CODE;

            return result;
        }
        public int[] get_id_code_size(List<ShowFile> info)
        {
            int[] result = new int[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].ID_CODE.Length;

            return result;
        }
        public String[] get_file_payoff(List<ShowFile> info)
        {
            String[] result = new String[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].FILE_PAYOFF_DATE;

            return result;
        }
        public int[] get_file_payoff_size(List<ShowFile> info)
        {
            int[] result = new int[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].FILE_PAYOFF_DATE.Length;

            return result;
        }
        public DateTime?[] get_payoff_date(List<ShowFile> info)
        {
            DateTime?[] result = new DateTime?[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = info[i].PAYOFF_DATE;

            return result;
        }
        public String[] get_acc_type(List<ShowFile> info, string acc_type)
        {
            String[] result = new String[info.Count];

            for (int i = 0; i < info.Count; i++)
                result[i] = acc_type;

            return result;
        }
    }
}