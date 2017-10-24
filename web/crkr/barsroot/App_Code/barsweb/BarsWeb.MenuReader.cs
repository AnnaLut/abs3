using System;
//using Infragistics.WebUI.UltraWebListbar;
using System.Configuration;


namespace bars.web
{

	public interface IMenuReader
	{
		//void	FillMenu(UltraWebListbar menu);
	}

	/// <summary>
	/// Заполняет меню из файла Web.config
	/// </summary>
	public class MenuReader	:	IMenuReader
	{
		public MenuReader()
		{
		}

		/*public void FillMenu(UltraWebListbar menu)
		{
			int curGrpNum = 0;
			string curGroupName;
			string curGroupTitle;

			while (curGrpNum != -1)
			{
				curGroupName  = "MenuGroup"+curGrpNum.ToString();
				curGroupTitle = ConfigurationSettings.AppSettings["MenuGroup"+curGrpNum.ToString()];

				if (curGroupTitle == null)
					break;
				
				// Add menu group
				menu.Groups.Add(curGroupTitle, curGrpNum.ToString());
				menu.Groups.FromKey(curGrpNum.ToString()).ItemAlign = "Left";


				// Search and add group items
				int curItemNum = 0;
				string curItemName;
				string curItemCommand;
				
				while (curItemNum != -1)
				{
					curItemName = ConfigurationSettings.AppSettings[curGroupName + ".Item" + curItemNum.ToString() + ".Name"];
					curItemCommand = ConfigurationSettings.AppSettings[curGroupName + ".Item" + curItemNum.ToString() + ".Url"];

					if (curItemName == null)
						break;

					menu.Groups.FromKey(curGrpNum.ToString()).Items.Add(curItemName,curItemNum.ToString());
					menu.Groups.FromKey(curGrpNum.ToString()).Items.FromKey(curItemNum.ToString()).TargetFrame = "main";
					menu.Groups.FromKey(curGrpNum.ToString()).Items.FromKey(curItemNum.ToString()).TargetUrl = curItemCommand;
					
					curItemNum++;
				}

				curGrpNum++;
			}

		}*/
	}
}
