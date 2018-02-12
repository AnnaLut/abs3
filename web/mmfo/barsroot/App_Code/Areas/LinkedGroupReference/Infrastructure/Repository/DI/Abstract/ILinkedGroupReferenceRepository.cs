using BarsWeb.Areas.LinkedGroupReference.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Abstract
{
    public interface ILinkedGroupReferenceRepository
    {
        void ClearLinkedGroups();

        void InsertLinkGroups(List<LinkGroup> groupList);

        String SetLinkGroups();

        List<String> GetMFOList();
    }
}
