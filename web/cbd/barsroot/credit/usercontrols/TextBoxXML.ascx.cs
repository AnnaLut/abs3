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
    public partial class TextBoxXML : System.Web.UI.UserControl
    {
        # region Приватные свойства
        private String ShowFilePattern = "ShowXMLData('{0}', '{1}'); return false;";
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Идентификатор данных в сессии
        /// </summary>
        [Category("Data")]
        public string XMLDataSessionID
        {
            get
            {
                if (this.ViewState["XML_DATA_SESSION_ID"] == null)
                {
                    this.ViewState["XML_DATA_SESSION_ID"] = "XML_DATA_" + Guid.NewGuid();
                }

                return (this.ViewState["XML_DATA_SESSION_ID"] as string);
            }
        }
        /// <summary>
        /// Строковое представление загруженого файла
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public String XMLData
        {
            get
            {
                if (this.Session[this.XMLDataSessionID] == null) return null;
                return (String)this.Session[this.XMLDataSessionID];
            }
            set
            {
                this.Session[this.XMLDataSessionID] = value;
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
                return (this.XMLData != null);
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
            String ShowScript = @"function ShowXMLData(XMLDataSessionID, FileName)
                                {
                                    var DialogOptions = 'resizable=yes,width=800,height=800';
                                    var rnd = Math.random();
                                    var result = window.open('/barsroot/credit/usercontrols/dialogs/textboxxml_show.aspx?sid=' + XMLDataSessionID + '&fname=' + escape(FileName) + '&rnd=' + rnd, 'view', DialogOptions);
                                }";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowScript", ShowScript, true);
        }
        protected override void OnPreRender(EventArgs e)
        {
            // при загруженом файле даем возможность просмотра
            ibShow.Enabled = this.HasData;
            ibShow.OnClientClick = String.Format(ShowFilePattern, this.XMLDataSessionID, this.FileName);

            base.OnPreRender(e);
        }
        protected void ibUpLoad_Click(object sender, ImageClickEventArgs e)
        {
            // загружаем данные файла
            if (fu.HasFile)
            {
                this.XMLData = new StreamReader(fu.FileContent).ReadToEnd();
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