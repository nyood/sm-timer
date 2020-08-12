#if defined _influx_tabranks_included
    #endinput
#endif
#define _influx_tabranks_included


native bool influx_trank_SendToClient( int client, bool send );

forward void Influx_trank_OnGetRank( int client, char[] sz, int size );
forward void Influx_trank_OnChangedSendVal( int client, bool oldVal, bool newVal, bool IsNative );

public SharedPlugin __pl_influx_tabranks =
{
    name = "influx_tabranks",
    file = "influx_tabranks_csgo.smx",
#if defined REQUIRE_PLUGIN
    required = 1
#else
    required = 0
#endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_influx_tabranks_SetNTVOptional()
{
    MarkNativeAsOptional( "influx_trank_SendToClient" );
}
#endif