using System;

namespace Bars.WebServices.MSP
{
    public interface IResultHolder
    {
        string HeaderError();
        string SaveDataError(string error);
    }    
}