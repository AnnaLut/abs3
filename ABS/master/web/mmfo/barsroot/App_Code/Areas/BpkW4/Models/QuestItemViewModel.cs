using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class QuestItemViewModel
    {
        public QuestItemViewModel(
            IEnumerable<V_LIST_ITEMS_Result> listInstanceByListCodeModel,
            W4_DKBO_QUESTION_Result foreachItemFromAnswers,
            string DEAL_ID)
        {
            listItems = listInstanceByListCodeModel;
            selectList = new List<SelectListItem>();
            foreach (var item in listInstanceByListCodeModel)
            {
                bool isListOptSelected = false;
                if (!string.IsNullOrEmpty(DEAL_ID))
                {
                    // привязка к уже заполненным данным на основании соответствия
                    // ATTRIBUTE_VALUE(заполненный ответ) = LIST_ITEM_NAME (справочник листа)
                    if (foreachItemFromAnswers.ATTRIBUTE_VALUE == item.LIST_ITEM_NAME)
                    {
                        isListOptSelected = true;
                    }
                }
                selectList.Add(new SelectListItem
                {
                    Text = item.LIST_ITEM_NAME,
                    Value = item.LIST_ITEM_CODE + "&" + foreachItemFromAnswers.QUEST_CODE,
                    Selected = isListOptSelected
                });
            }
            LIST_CODE = listInstanceByListCodeModel.Count() > 0 ? listInstanceByListCodeModel.First().LIST_CODE : "";
        }

        public QuestItemViewModel(W4_DKBO_QUESTION_Result item)
        {
            singleItem = item;
        }

        public IEnumerable<V_LIST_ITEMS_Result> listItems { get; set; }

        public List<SelectListItem> selectList { get; set; }

        public string LIST_CODE { get; set; }

        public W4_DKBO_QUESTION_Result singleItem { get; set; }


    }
}
