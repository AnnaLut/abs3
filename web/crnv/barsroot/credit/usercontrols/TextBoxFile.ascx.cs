using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.ComponentModel;
using System.IO;

namespace Bars.UserControls
{
    public partial class TextBoxFile : System.Web.UI.UserControl
    {
        # region Приватные свойства
        private String ShowFilePattern = "ShowFileData('{0}', '{1}'); return false;";
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Идентификатор данных в сессии
        /// </summary>
        [Category("Data")]
        public string FileDataSessionID
        {
            get
            {
                if (this.ViewState["FILE_DATA_SESSION_ID"] == null)
                {
                    this.ViewState["FILE_DATA_SESSION_ID"] = "FILE_DATA_" + Guid.NewGuid();
                }

                return (this.ViewState["FILE_DATA_SESSION_ID"] as string);
            }
        }
        /// <summary>
        /// Байтовое представление загруженого файла
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public byte[] FileData
        {
            get
            {
                Trace.Write("get");
                if (this.Session[this.FileDataSessionID] == null) return null;
                return (byte[])this.Session[this.FileDataSessionID];
            }
            set
            {
                Trace.Write("set");
                this.Session[this.FileDataSessionID] = value;
            }
        }
        /// <summary>
        /// Имя загруженого файла
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public String FileName
        {
            get
            {
                String sFileName = (this.ViewState["FILENAME"] == null ? "" : (String)this.ViewState["FILENAME"]);
                return sFileName;
            }
            set
            {
                ViewState["FILENAME"] = value;
            }
        }
        /// <summary>
        /// Загружен ли файл
        /// </summary>
        [Category("Data")]
        public bool HasData
        {
            get
            {
                return (this.FileData != null);
            }
        }
        /// <summary>
        /// Url доступа к файлу
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Bindable(true, BindingDirection.OneWay)]
        public bool IsRequired
        {
            get
            {
                bool bIsRequired = (this.ViewState["ISREQUIRED"] == null ? true : (bool)this.ViewState["ISREQUIRED"]);
                return bIsRequired;
            }
            set
            {
                ViewState["ISREQUIRED"] = value;
            }
        }
        /// <summary>
        /// Только для чтения
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(false)]
        [Bindable(true, BindingDirection.OneWay)]
        public bool ReadOnly
        {
            get { return !this.fu.Enabled; }
            set
            {
                this.fu.Enabled = !value;
                this.ibUpLoad.Enabled = !value;
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.GetCurrent(this.Page).RegisterPostBackControl(ibUpLoad);

            // регистрируем скрипт для просмотра
            String ShowScript = @"function ShowFileData(FileDataSessionID, FileName)
                                {
                                    var DialogOptions = 'width=10,height=10';
                                    var rnd = Math.random();
                                    var result = window.open('/barsroot/credit/usercontrols/dialogs/textboxfile_show.ashx?sid=' + FileDataSessionID + '&fname=' + escape(FileName) + '&rnd=' + rnd, 'view', DialogOptions);
                                }";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowScript", ShowScript, true);
        }
        protected override void OnPreRender(EventArgs e)
        {
            // при загруженом файле даем возможность просмотра
            ibShow.Enabled = this.HasData;
            ibShow.OnClientClick = String.Format(ShowFilePattern, this.FileDataSessionID, this.FileName);

            base.OnPreRender(e);
        }
        protected void ibUpLoad_Click(object sender, ImageClickEventArgs e)
        {
            // загружаем данные файла
            Trace.Write("fu.HasFile = " + fu.HasFile);
            if (fu.HasFile)
            {
                this.FileData = fu.FileBytes;
                this.FileName = Path.GetFileName(fu.FileName);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "file_not_loaded", "alert('Файл не загружен');", true);
            }
        }
        # endregion
    }
}