#pragma newdecls required

#include <influx/core>

ArrayList g_aCmds;

public Plugin myinfo =
{
    author = INF_AUTHOR,
    url = INF_URL,
    name = INF_NAME..." - Silent Chat Commands",
    description = "Hides certain public chat commands",
    version = INF_VERSION
};

public void OnPluginStart()
{
    g_aCmds = new ArrayList(256, 0);
}

public void OnMapStart()
{
    static char szFile[PLATFORM_MAX_PATH] = "configs/influx/influx_silentcmds.txt";

    if(szFile[0] == 'c')
        BuildPath(Path_SM, szFile, sizeof(szFile), szFile);
    
    if(!FileExists(szFile))
        SetFailState("Couldn't find txt file: %s", szFile);

    File hFile = OpentFile(szFile, "r");
    if(!hFile)
        return;

    g_aCmds.Clear();
    
    char line[256];
    while(!hFile.EndofFile() && hFile.ReadLine(line, sizeof(line)))
    {
        TrimString(line);
        if(line[0] == '/' && line[1] == '/')
            continue;
        
        g_aCmds.PushString(line);
    }

    delete hFile;
}

public Action OnClientSayCommand(int iClient, const char[] cmd, const char[] args)
{
    if(!IsChatTrigger())
        return Plugin_Continue;
    
    static char szTrigger[256];
    strcopy(szTrigger, sizeof(szTrigger), args);

    return IsSilentTrigger(szTrigger);
}

Action IsSilentTrigger(const char[] trigger)
{
    char szBuffer[256];
    int a;
    for(int i; i < g_aCmds.Length; i++)
    {
        g_aCmds.GetString(i, szBuffer, sizeof(szBuffer));
        a = StrContains(trigger, szBuffer);

        if(a != -1 && a < 2)
            return Plugin_Handled;
    }

    return Plugin_Continue;
}