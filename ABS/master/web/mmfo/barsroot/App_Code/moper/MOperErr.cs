using System;
using System.Data;
using System.Collections;

public class MOperErr
{
    public bool HasErr
    {
        get { return (ErrList.Count > 0); }
    }
    //-------------------------------
    private ArrayList ErrList = new ArrayList();
    //-------------------------------
    public MOperErr()
	{
	}
    //-------------------------------
    public void SetErr(string ErrMsg)
    {
        if (ErrMsg != null)
            ErrList.Add(ErrMsg);
    }
    public string GetHtmlView()
    {
        string text = Resources.moper.GlobalResource.Msg_Ochibki + "<BR>";
        for (int i = 0; i < this.ErrList.Count; i++) text += "<BR>" + Convert.ToString(ErrList[i]);

        return text;
    }
}
