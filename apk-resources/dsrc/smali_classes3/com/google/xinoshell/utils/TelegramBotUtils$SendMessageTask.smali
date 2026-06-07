.class Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;
.super Landroid/os/AsyncTask;
.source "TelegramBotUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/utils/TelegramBotUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SendMessageTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field private final callback:Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

.field private fullResponse:Ljava/lang/String;

.field private isSuccess:Z

.field private startTime:J


# direct methods
.method constructor <init>(Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    .line 33
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    .line 34
    iput-object p1, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->callback:Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    .line 35
    return-void
.end method


# virtual methods
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

    .line 26
    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->doInBackground([Ljava/lang/String;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected varargs doInBackground([Ljava/lang/String;)Ljava/lang/Void;
    .locals 17
    .param p1, "params"    # [Ljava/lang/String;

    .line 44
    move-object/from16 v1, p0

    const/4 v2, 0x0

    aget-object v3, p1, v2

    .line 45
    .local v3, "botToken":Ljava/lang/String;
    const/4 v0, 0x1

    aget-object v4, p1, v0

    .line 46
    .local v4, "chatId":Ljava/lang/String;
    const/4 v5, 0x2

    aget-object v5, p1, v5

    .line 47
    .local v5, "message":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "https://api.telegram.org/bot"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "/sendMessage"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 50
    .local v6, "urlString":Ljava/lang/String;
    :try_start_0
    const-string v8, "TelegramBotUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Creating connection to: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 51
    new-instance v8, Ljava/net/URL;

    invoke-direct {v8, v6}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 52
    .local v8, "url":Ljava/net/URL;
    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v9

    check-cast v9, Ljava/net/HttpURLConnection;

    .line 53
    .local v9, "conn":Ljava/net/HttpURLConnection;
    const-string v10, "POST"

    invoke-virtual {v9, v10}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 54
    const-string v10, "Content-Type"

    const-string v11, "application/json"

    invoke-virtual {v9, v10, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 56
    const/16 v0, 0x3a98

    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 57
    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 59
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "{\"chat_id\":\""

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v10, "\",\"text\":\""

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v10, "\",\"parse_mode\":\"HTML\"}"

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v10, v0

    .line 61
    .local v10, "jsonPayload":Ljava/lang/String;
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v10, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    move-object v11, v0

    .line 63
    .local v11, "input":[B
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-object v12, v0

    .line 64
    .local v12, "os":Ljava/io/OutputStream;
    :try_start_1
    array-length v0, v11

    invoke-virtual {v12, v11, v2, v0}, Ljava/io/OutputStream;->write([BII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 65
    if-eqz v12, :cond_0

    :try_start_2
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 67
    .end local v12    # "os":Ljava/io/OutputStream;
    :cond_0
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0

    .line 69
    .local v0, "responseCode":I
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    .line 70
    .local v12, "response":Ljava/lang/StringBuilder;
    new-instance v13, Ljava/io/BufferedReader;

    new-instance v14, Ljava/io/InputStreamReader;

    .line 71
    const/16 v15, 0xc8

    if-ne v0, v15, :cond_1

    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v15

    goto :goto_0

    :cond_1
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v15

    :goto_0
    invoke-direct {v14, v15}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v13, v14}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 74
    .local v13, "reader":Ljava/io/BufferedReader;
    :goto_1
    invoke-virtual {v13}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v14

    move-object v15, v14

    .local v15, "line":Ljava/lang/String;
    if-eqz v14, :cond_2

    .line 75
    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 77
    :cond_2
    invoke-virtual {v13}, Ljava/io/BufferedReader;->close()V

    .line 79
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    iput-object v14, v1, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->fullResponse:Ljava/lang/String;

    .line 80
    new-instance v14, Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    const/16 v16, 0x0

    :try_start_3
    iget-object v7, v1, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->fullResponse:Ljava/lang/String;

    invoke-direct {v14, v7}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 81
    .local v14, "jsonResponse":Lorg/json/JSONObject;
    const-string v7, "ok"

    invoke-virtual {v14, v7, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v7

    iput-boolean v7, v1, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->isSuccess:Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 83
    return-object v16

    .line 63
    .end local v0    # "responseCode":I
    .end local v13    # "reader":Ljava/io/BufferedReader;
    .end local v14    # "jsonResponse":Lorg/json/JSONObject;
    .end local v15    # "line":Ljava/lang/String;
    .local v12, "os":Ljava/io/OutputStream;
    :catchall_0
    move-exception v0

    const/16 v16, 0x0

    move-object v7, v0

    if-eqz v12, :cond_3

    :try_start_4
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception v0

    :try_start_5
    invoke-virtual {v7, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v3    # "botToken":Ljava/lang/String;
    .end local v4    # "chatId":Ljava/lang/String;
    .end local v5    # "message":Ljava/lang/String;
    .end local v6    # "urlString":Ljava/lang/String;
    .end local p1    # "params":[Ljava/lang/String;
    :cond_3
    :goto_2
    throw v7
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0

    .line 84
    .end local v8    # "url":Ljava/net/URL;
    .end local v9    # "conn":Ljava/net/HttpURLConnection;
    .end local v10    # "jsonPayload":Ljava/lang/String;
    .end local v11    # "input":[B
    .end local v12    # "os":Ljava/io/OutputStream;
    .restart local v3    # "botToken":Ljava/lang/String;
    .restart local v4    # "chatId":Ljava/lang/String;
    .restart local v5    # "message":Ljava/lang/String;
    .restart local v6    # "urlString":Ljava/lang/String;
    .restart local p1    # "params":[Ljava/lang/String;
    :catch_0
    move-exception v0

    goto :goto_3

    :catch_1
    move-exception v0

    const/16 v16, 0x0

    .line 85
    .local v0, "e":Ljava/lang/Exception;
    :goto_3
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "{\"ok\":false,\"description\":\""

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\"}"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v1, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->fullResponse:Ljava/lang/String;

    .line 86
    iput-boolean v2, v1, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->isSuccess:Z

    .line 87
    return-object v16
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

    .line 26
    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->onPostExecute(Ljava/lang/Void;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/Void;)V
    .locals 2
    .param p1, "result"    # Ljava/lang/Void;

    .line 93
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    .line 95
    iget-object v0, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->callback:Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    if-eqz v0, :cond_1

    .line 96
    iget-boolean v0, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->isSuccess:Z

    if-eqz v0, :cond_0

    .line 97
    iget-object v0, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->callback:Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    iget-object v1, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->fullResponse:Ljava/lang/String;

    invoke-interface {v0, v1}, Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;->onSuccess(Ljava/lang/String;)V

    goto :goto_0

    .line 99
    :cond_0
    iget-object v0, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->callback:Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    iget-object v1, p0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->fullResponse:Ljava/lang/String;

    invoke-interface {v0, v1}, Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;->onError(Ljava/lang/String;)V

    .line 102
    :cond_1
    :goto_0
    return-void
.end method

.method protected onPreExecute()V
    .locals 0

    .line 39
    invoke-super {p0}, Landroid/os/AsyncTask;->onPreExecute()V

    .line 40
    return-void
.end method
