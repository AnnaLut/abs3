using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MainOptionAttribute
/// </summary>
   [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = true)]
public class MainOptionAttribute : Attribute
{
	public MainOptionAttribute(string Name,bool CanInheritance)
	{
        this.OptionName = Name;
        this.CanInheritance = CanInheritance;
	}
    public string OptionName { get; set; }
    public bool CanInheritance { get; set; }
}