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

using System.Collections.Generic;
using credit;
using Bars.UserControls;

using Bars.Classes;
using ibank.core;

public partial class credit_survey : Bars.BarsPage
{
    # region Приватные свойства
    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    # endregion

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);

        BbConnection con = new BbConnection();

        try
        {
            FillSurvey(con);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    # endregion

    # region Приватные методы
    public void FillSurvey(BbConnection con)
    {
        Common cmn = new Common(con, BID_ID);

        // берем все групы
        foreach (VWcsBidSurveyGroupsRecord ssgRecord in cmn.BidSurveyGroups)
        {
            // создаем групу
            HtmlTableRow tr = new HtmlTableRow();

            // контейнер кнопки        
            HtmlTableCell tcBCont = new HtmlTableCell();
            tcBCont.Attributes.Add("class", "buttonContainer");

            ImageButton ibShowHide = new ImageButton();
            ibShowHide.ImageUrl = "/Common/Images/default/16/win_max.gif";
            ibShowHide.OnClientClick = "ShowHide(this); return false;";
            ibShowHide.Attributes.Add("grpid", ssgRecord.GROUP_ID);
            ibShowHide.Attributes.Add("grpvisible", "0");
            tcBCont.Controls.Add(ibShowHide);

            // контейнер имени групи        
            HtmlTableCell tcGName = new HtmlTableCell();
            tcGName.ColSpan = 2;
            tcGName.Attributes.Add("class", "groupTitle");
            tcGName.InnerText = ssgRecord.GROUP_NAME;

            tr.Cells.Add(tcBCont);
            tr.Cells.Add(tcGName);

            tbSurveyContainer.Rows.Add(tr);

            // вопросы группы
            List<VWcsBidSurveyGroupQuestsRecord> ssqRecords = (new VWcsBidSurveyGroupQuests(con)).SelectBidSurveyGroupQuests(BID_ID, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
            foreach (VWcsBidSurveyGroupQuestsRecord ssqRecord in ssqRecords)
            {
                // раздел
                if (ssqRecord.RECTYPE_ID == "SECTION")
                {
                    // строчка заголовка раздела
                    HtmlTableRow htrSection = new HtmlTableRow();
                    htrSection.Attributes.Add("grpid", ssqRecord.GROUP_ID);
                    htrSection.Attributes.Add("grpvisible", "0");
                    htrSection.Attributes.Add("class", "rowHidden");

                    HtmlTableRow htrSeparator = new HtmlTableRow();
                    htrSeparator.Attributes.Add("grpid", ssqRecord.GROUP_ID);
                    htrSeparator.Attributes.Add("grpvisible", "0");
                    htrSeparator.Attributes.Add("class", "rowHidden");
                    htrSeparator.Height = "20px";

                    HtmlTableCell htcSectionBt = new HtmlTableCell();
                    htcSectionBt.Attributes.Add("class", "buttonContainer");

                    HtmlTableCell htcSectionTitle = new HtmlTableCell();
                    htcSectionTitle.Attributes.Add("class", "sectionTitle");
                    htcSectionTitle.InnerText = ssqRecord.QUESTION_NAME;
                    htcSectionTitle.ColSpan = 2;

                    htrSection.Cells.Add(htcSectionBt);
                    htrSection.Cells.Add(htcSectionTitle);
                    tbSurveyContainer.Rows.Add(htrSeparator);
                    tbSurveyContainer.Rows.Add(htrSection);

                    continue;
                }

                // добавляем вопрос
                HtmlTableRow trQuest = new HtmlTableRow();
                trQuest.Attributes.Add("grpid", ssqRecord.GROUP_ID);
                trQuest.Attributes.Add("grpvisible", "0");
                trQuest.Attributes.Add("class", "rowHidden");

                // контейнер кнопки        
                HtmlTableCell tcQBCont = new HtmlTableCell();
                tcQBCont.Attributes.Add("class", "buttonContainer");

                // название вопроса
                HtmlTableCell tcQTitle = new HtmlTableCell();
                tcQTitle.Attributes.Add("class", "questionTitle");
                tcQTitle.InnerText = String.Format("{0} :", ssqRecord.QUESTION_NAME);

                // значение вопроса
                HtmlTableCell tcQValue = new HtmlTableCell();
                tcQValue.Attributes.Add("class", "questionValue");

                Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID);
                if (HasAnsw.Value == 1)
                {
                    # region Switch TYPE_ID
                    switch (ssqRecord.TYPE_ID)
                    {
                        case "TEXT":
                            tcQValue.InnerText = cmn.wu.GET_ANSW_TEXT(BID_ID, ssqRecord.QUESTION_ID);
                            break;
                        case "NUMB":
                            tcQValue.InnerText = String.Format("{0}", cmn.wu.GET_ANSW_NUMB(BID_ID, ssqRecord.QUESTION_ID));
                            break;
                        case "DECIMAL":
                            tcQValue.InnerText = String.Format("{0:F2}", cmn.wu.GET_ANSW_DECIMAL(BID_ID, ssqRecord.QUESTION_ID));
                            break;
                        case "DATE":
                            tcQValue.InnerText = String.Format("{0:d}", cmn.wu.GET_ANSW_DATE(BID_ID, ssqRecord.QUESTION_ID));
                            break;
                        case "LIST":
                            tcQValue.InnerText = String.Format("{0} - {1}", cmn.wu.GET_ANSW_LIST(BID_ID, ssqRecord.QUESTION_ID), cmn.wu.GET_ANSW_LIST_TEXT(BID_ID, ssqRecord.QUESTION_ID));
                            break;
                        case "REFER":
                            tcQValue.InnerText = String.Format("{0} - {1}", cmn.wu.GET_ANSW_REFER(BID_ID, ssqRecord.QUESTION_ID), cmn.wu.GET_ANSW_REFER_TEXT(BID_ID, ssqRecord.QUESTION_ID));
                            break;
                        case "BOOL":
                            tcQValue.InnerText = cmn.wu.GET_ANSW_BOOL(BID_ID, ssqRecord.QUESTION_ID).Value == 1 ? "Так" : "Ні";
                            break;
                    }
                    # endregion
                }
                else
                {
                    tcQValue.InnerText = String.Empty;
                }

                trQuest.Cells.Add(tcQBCont);
                trQuest.Cells.Add(tcQTitle);
                trQuest.Cells.Add(tcQValue);

                tbSurveyContainer.Rows.Add(trQuest);
            }
        }
    }
    # endregion
}