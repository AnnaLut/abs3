using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

using ibank.core;

namespace credit
{
    /// <summary>
    /// Статический класс с часто используемой функциональностью
    /// </summary>
    public class Common
    {
        # region Приватные свойства
        private Hashtable _StateColors;

        // Базовые переменные
        private BbConnection _con;
        private Decimal? _BID_ID;

        // Параметры обеспечения/страховки
        private String _ID;
        private Decimal? _NUM;
        private String _ID2;
        private Decimal? _NUM2;

        // Работа с пакетами
        private WcsPack _wp;
        private WcsUtl _wu;
        private WcsSync _ws;

        // Получение данных
        private List<VWcsBidSurveyGroupsRecord> _BidSurveyGroups;
        private List<VWcsBidGrtSurveyGroupsRecord> _BidGrtSurveyGroups;
        private List<VWcsBidInsSurveyGroupsRecord> _BidInsSurveyGroups;
        private List<VWcsBidGrtInsSurGroupsRecord> _BidGrtInsSurGroups;
        # endregion

        # region Публичные свойства
        public Hashtable StateColors
        {
            get
            {
                if (_StateColors == null)
                {
                    _StateColors = new Hashtable();

                    _StateColors.Add("NEW_SCANCOPY", Color.FromArgb(255, 255, 128));
                    _StateColors.Add("NEW_AUTH", Color.FromArgb(255, 255, 128));
                    _StateColors.Add("NEW_DENY", Color.FromArgb(255, 75, 75));
                    _StateColors.Add("NEW_ADDWORK", Color.FromArgb(255, 255, 100));
                    _StateColors.Add("NEW_SURVEY_PRINT_OM", Color.FromArgb(255, 255, 100));
                    _StateColors.Add("SYS_ERR", Color.FromArgb(175, 175, 175));
                    _StateColors.Add("APP_ERR", Color.FromArgb(175, 175, 175));
                    _StateColors.Add("NEW_DONE", Color.FromArgb(150, 255, 255));
                    _StateColors.Add("NEW_SURVEY", Color.FromArgb(255, 255, 255));
                    _StateColors.Add("NEW_ADDSERVICES", Color.FromArgb(255, 255, 255));
                    _StateColors.Add("NEW_SURVEY_PRINT", Color.FromArgb(255, 255, 255));
                    _StateColors.Add("NEW_PARTNER", Color.FromArgb(125, 255, 125));
                    _StateColors.Add("NEW_DOCUMENTS", Color.FromArgb(255, 255, 255));
                    _StateColors.Add("NEW_VISA_0", Color.FromArgb(150, 150, 255));
                    _StateColors.Add("NEW_VISA_1", Color.FromArgb(150, 150, 255));
                    _StateColors.Add("ASIDE", Color.FromArgb(185, 110, 255));
                }

                return _StateColors;
            }
        }

        // Работа с пакетами
        public WcsPack wp
        {
            get
            {
                if (_wp == null)
                {
                    if (_con == null) _con = new BbConnection();
                    _wp = new WcsPack(_con);
                }
                return _wp;
            }
        }
        public WcsUtl wu
        {
            get
            {
                if (_wu == null)
                {
                    if (_con == null) _con = new BbConnection();
                    _wu = new WcsUtl(_con);
                }
                return _wu;
            }
        }
        public WcsSync ws
        {
            get
            {
                if (_ws == null)
                {
                    if (_con == null) _con = new BbConnection();
                    _ws = new WcsSync(_con);
                }
                return _ws;
            }
        }

        // Получение данных
        public List<VWcsBidSurveyGroupsRecord> BidSurveyGroups
        {
            get
            {
                if (_BidSurveyGroups == null)
                {
                    _BidSurveyGroups = (new VWcsBidSurveyGroups(_con)).SelectBidSurveyGroups(_BID_ID);
                }

                return _BidSurveyGroups;
            }
        }
        public List<VWcsBidGrtSurveyGroupsRecord> BidGrtSurveyGroups
        {
            get
            {
                if (_BidGrtSurveyGroups == null)
                {
                    _BidGrtSurveyGroups = (new VWcsBidGrtSurveyGroups(_con)).SelectBidGrtSurveyGroups(_BID_ID, _ID, _NUM);
                }

                return _BidGrtSurveyGroups;
            }
        }
        public List<VWcsBidInsSurveyGroupsRecord> BidInsSurveyGroups
        {
            get
            {
                if (_BidInsSurveyGroups == null)
                {
                    _BidInsSurveyGroups = (new VWcsBidInsSurveyGroups(_con)).SelectBidInsSurveyGroups(_BID_ID, _ID, _NUM);
                }

                return _BidInsSurveyGroups;
            }
        }
        public List<VWcsBidGrtInsSurGroupsRecord> BidGrtInsSurGroups
        {
            get
            {
                if (_BidGrtInsSurGroups == null)
                {
                    _BidGrtInsSurGroups = (new VWcsBidGrtInsSurGroups(_con)).SelectBidGrtInsSurGroups(_BID_ID, _ID, _NUM, _ID2, _NUM2);
                }

                return _BidGrtInsSurGroups;
            }
        }
        # endregion

        # region Приватные методы
        # endregion

        # region Публичные методы
        public String GetParsedFormHtml(String FORM_ID)
        {
            List<WcsFormsRecord> rec = (new WcsForms(_con)).SelectForm(FORM_ID);
            String res = String.Empty;

            if (rec.Count > 0)
            {
                String str = rec[0].HTML;

                while (str.Length > 3000)
                {
                    String str3000 = str.Substring(0, 3000);
                    Int32 lstIndex = str3000.LastIndexOf(":#");

                    str3000 = str.Substring(0, (lstIndex == -1 || lstIndex == 0 ? 3000 : lstIndex));
                    res += wu.PARSE_SQL(_BID_ID, str3000);

                    str = str.Remove(0, str3000.Length);
                }

                res += wu.PARSE_SQL(_BID_ID, str);
            }

            return res;
        }
        # endregion

        # region Конструктор
        public Common()
        {
        }
        public Common(BbConnection con)
        {
            _con = con;
        }
        public Common(BbConnection con, Decimal? BID_ID)
        {
            _con = con;
            _BID_ID = BID_ID;
        }
        public Common(BbConnection con, Decimal? BID_ID, String ID, Decimal? NUM)
        {
            _con = con;
            _BID_ID = BID_ID;
            _ID = ID;
            _NUM = NUM;
        }
        public Common(BbConnection con, Decimal? BID_ID, String ID, Decimal? NUM, String ID2, Decimal? NUM2)
        {
            _con = con;
            _BID_ID = BID_ID;
            _ID = ID;
            _NUM = NUM;
            _ID2 = ID2;
            _NUM2 = NUM2;
        }
        # endregion
    }
}