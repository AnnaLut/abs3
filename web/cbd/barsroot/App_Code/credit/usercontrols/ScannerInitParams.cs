using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

/// <summary>
/// Класс для работы с настройками сканирования
/// </summary>
namespace Bars.UserControls
{
    [Serializable]
    public class ScannerInitParams
    {
        # region Приватные свойства
        private Boolean _UseTwainInterface = false;

        private Int32 _TwainUnits = 0;
        private Int32 _TwainPixelType = 1;
        private Int32 _TwainResolution = 100;

        private Boolean _TwainAutoDeskew = true;
        private Boolean _TwainAutoBorder = true;

        private Boolean _AutoZoom = true;
        private Boolean _WaitForAcquire = true;
        private Boolean _ShowTwainProgress = true;

        private Int32 _Compression = 1;
        # endregion

        # region Публичные свойства
        public Boolean UseTwainInterface
        {
            get { return _UseTwainInterface; }
            set { _UseTwainInterface = value; }
        }

        public Int32 TwainUnits
        {
            get { return _TwainUnits; }
            set { _TwainUnits = value; }
        }
        public Int32 TwainPixelType
        {
            get { return _TwainPixelType; }
            set { _TwainPixelType = value; }
        }
        public Int32 TwainResolution
        {
            get { return _TwainResolution; }
            set { _TwainResolution = value; }
        }

        public Boolean TwainAutoDeskew
        {
            get { return _TwainAutoDeskew; }
            set { _TwainAutoDeskew = value; }
        }
        public Boolean TwainAutoBorder
        {
            get { return _TwainAutoBorder; }
            set { _TwainAutoBorder = value; }
        }

        public Boolean AutoZoom
        {
            get { return _AutoZoom; }
            set { _AutoZoom = value; }
        }
        public Boolean WaitForAcquire
        {
            get { return _WaitForAcquire; }
            set { _WaitForAcquire = value; }
        }
        public Boolean ShowTwainProgress
        {
            get { return _ShowTwainProgress; }
            set { _ShowTwainProgress = value; }
        }

        public Int32 Compression
        {
            get { return _Compression; }
            set { _Compression = value; }
        }
        # endregion

        # region Конструктор
        public ScannerInitParams(OracleConnection con)
        {
            OracleCommand cmdUINT = new OracleCommand("select nvl(min(pg.val), 0) as val from params$global pg where pg.par = 'SCN_UINT'", con);
            this._UseTwainInterface = (Convert.ToInt32(cmdUINT.ExecuteScalar()) == 0 ? false : true);

            OracleCommand cmdPXT = new OracleCommand("select nvl(min(pg.val), 0) as val from params$global pg where pg.par = 'SCN_PXT'", con);
            this._TwainPixelType = Convert.ToInt32(cmdPXT.ExecuteScalar());

            OracleCommand cmdRES = new OracleCommand("select nvl(min(pg.val), 0) as val from params$global pg where pg.par = 'SCN_RES'", con);
            this._TwainResolution = Convert.ToInt32(cmdRES.ExecuteScalar());

            OracleCommand cmdCOM = new OracleCommand("select nvl(min(pg.val), 0) as val from params$global pg where pg.par = 'SCN_COM'", con);
            this._Compression = Convert.ToInt32(cmdCOM.ExecuteScalar());
        }
        # endregion
    }
}