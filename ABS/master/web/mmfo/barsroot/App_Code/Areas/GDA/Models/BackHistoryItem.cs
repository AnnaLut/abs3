using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class BackHistoryItem
{
    public ulong OBJECT_ID { get; set; }
    public string PROCESS_NAME { get; set; }
    public string ACTIVITY_NAME { get; set; }
    public string ACTIVITY_STATE_NAME { get; set; }
    public string ACTIVITY_HISTORY_TEXT { get; set; }
    public DateTime ACTIVITY_HISTORY_SYS_TIME { get; set; }
    public int ACTIVITY_HISTORY_USER_ID { get; set; }
}