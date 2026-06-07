.class Lcom/google/firebase/messaging/Metadata;
.super Ljava/lang/Object;
.source "Metadata.java"


# static fields
.field private static final ACTION_C2DM_REGISTER:Ljava/lang/String; = "com.google.android.c2dm.intent.REGISTER"

.field private static final ACTION_IID_TOKEN_REQUEST:Ljava/lang/String; = "com.google.iid.TOKEN_REQUEST"

.field static final GMSCORE_NOT_FOUND:I = 0x0

.field private static final GMSCORE_SEND_PERMISSION:Ljava/lang/String; = "com.google.android.c2dm.permission.SEND"

.field static final GMS_PACKAGE:Ljava/lang/String; = "com.google.android.gms"

.field static final IID_VIA_RECEIVER:I = 0x2

.field static final IID_VIA_SERVICE:I = 0x1


# instance fields
.field private appVersionCode:Ljava/lang/String;

.field private appVersionName:Ljava/lang/String;

.field private final context:Landroid/content/Context;

.field private gmsVersionCode:I

.field private iidImplementation:I


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    const/4 v0, 0x0

    iput v0, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I

    .line 73
    iput-object p1, p0, Lcom/google/firebase/messaging/Metadata;->context:Landroid/content/Context;

    .line 74
    return-void
.end method

.method static getDefaultSenderId(Lcom/google/firebase/FirebaseApp;)Ljava/lang/String;
    .locals 6
    .param p0, "app"    # Lcom/google/firebase/FirebaseApp;

    .line 142
    invoke-virtual {p0}, Lcom/google/firebase/FirebaseApp;->getOptions()Lcom/google/firebase/FirebaseOptions;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/firebase/FirebaseOptions;->getGcmSenderId()Ljava/lang/String;

    move-result-object v0

    .line 143
    .local v0, "senderId":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 144
    return-object v0

    .line 146
    :cond_0
    invoke-virtual {p0}, Lcom/google/firebase/FirebaseApp;->getOptions()Lcom/google/firebase/FirebaseOptions;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/firebase/FirebaseOptions;->getApplicationId()Ljava/lang/String;

    move-result-object v1

    .line 147
    .local v1, "appId":Ljava/lang/String;
    const-string v2, "1:"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 149
    return-object v1

    .line 152
    :cond_1
    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 153
    .local v2, "parts":[Ljava/lang/String;
    array-length v3, v2

    const/4 v4, 0x2

    const/4 v5, 0x0

    if-ge v3, v4, :cond_2

    .line 154
    return-object v5

    .line 156
    :cond_2
    const/4 v3, 0x1

    aget-object v3, v2, v3

    .line 157
    .local v3, "projectId":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 158
    return-object v5

    .line 160
    :cond_3
    return-object v3
.end method

.method private getPackageInfo(Ljava/lang/String;)Landroid/content/pm/PackageInfo;
    .locals 3
    .param p1, "packageName"    # Ljava/lang/String;

    .line 201
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 202
    :catch_0
    move-exception v0

    .line 203
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Failed to find package "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "FirebaseMessaging"

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    const/4 v1, 0x0

    return-object v1
.end method

.method private declared-synchronized populateAppVersionInfo()V
    .locals 2

    monitor-enter p0

    .line 192
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/google/firebase/messaging/Metadata;->getPackageInfo(Ljava/lang/String;)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 193
    .local v0, "info":Landroid/content/pm/PackageInfo;
    if-eqz v0, :cond_0

    .line 194
    iget v1, v0, Landroid/content/pm/PackageInfo;->versionCode:I

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/google/firebase/messaging/Metadata;->appVersionCode:Ljava/lang/String;

    .line 195
    iget-object v1, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    iput-object v1, p0, Lcom/google/firebase/messaging/Metadata;->appVersionName:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 197
    .end local p0    # "this":Lcom/google/firebase/messaging/Metadata;
    :cond_0
    monitor-exit p0

    return-void

    .line 191
    .end local v0    # "info":Landroid/content/pm/PackageInfo;
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method


# virtual methods
.method declared-synchronized getAppVersionCode()Ljava/lang/String;
    .locals 1

    monitor-enter p0

    .line 166
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->appVersionCode:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 167
    invoke-direct {p0}, Lcom/google/firebase/messaging/Metadata;->populateAppVersionInfo()V

    .line 169
    .end local p0    # "this":Lcom/google/firebase/messaging/Metadata;
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->appVersionCode:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 165
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method declared-synchronized getAppVersionName()Ljava/lang/String;
    .locals 1

    monitor-enter p0

    .line 174
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->appVersionName:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 175
    invoke-direct {p0}, Lcom/google/firebase/messaging/Metadata;->populateAppVersionInfo()V

    .line 177
    .end local p0    # "this":Lcom/google/firebase/messaging/Metadata;
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->appVersionName:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 173
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method declared-synchronized getGmsVersionCode()I
    .locals 2

    monitor-enter p0

    .line 182
    :try_start_0
    iget v0, p0, Lcom/google/firebase/messaging/Metadata;->gmsVersionCode:I

    if-nez v0, :cond_0

    .line 183
    const-string v0, "com.google.android.gms"

    invoke-direct {p0, v0}, Lcom/google/firebase/messaging/Metadata;->getPackageInfo(Ljava/lang/String;)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 184
    .local v0, "info":Landroid/content/pm/PackageInfo;
    if-eqz v0, :cond_0

    .line 185
    iget v1, v0, Landroid/content/pm/PackageInfo;->versionCode:I

    iput v1, p0, Lcom/google/firebase/messaging/Metadata;->gmsVersionCode:I

    .line 188
    .end local v0    # "info":Landroid/content/pm/PackageInfo;
    .end local p0    # "this":Lcom/google/firebase/messaging/Metadata;
    :cond_0
    iget v0, p0, Lcom/google/firebase/messaging/Metadata;->gmsVersionCode:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 181
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method declared-synchronized getIidImplementation()I
    .locals 8

    monitor-enter p0

    .line 96
    :try_start_0
    iget v0, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I

    if-eqz v0, :cond_0

    .line 97
    iget v0, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 100
    .end local p0    # "this":Lcom/google/firebase/messaging/Metadata;
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/google/firebase/messaging/Metadata;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 102
    .local v0, "pm":Landroid/content/pm/PackageManager;
    const-string v1, "com.google.android.c2dm.permission.SEND"

    const-string v2, "com.google.android.gms"

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 103
    .local v1, "permissionState":I
    const/4 v2, -0x1

    const/4 v3, 0x0

    if-ne v1, v2, :cond_1

    .line 104
    const-string v2, "FirebaseMessaging"

    const-string v4, "Google Play services missing or without correct permission."

    invoke-static {v2, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 105
    monitor-exit p0

    return v3

    .line 112
    :cond_1
    :try_start_2
    invoke-static {}, Lcom/google/android/gms/common/util/PlatformVersion;->isAtLeastO()Z

    move-result v2

    const/4 v4, 0x1

    if-nez v2, :cond_2

    .line 113
    new-instance v2, Landroid/content/Intent;

    const-string v5, "com.google.android.c2dm.intent.REGISTER"

    invoke-direct {v2, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 114
    .local v2, "intent":Landroid/content/Intent;
    const-string v5, "com.google.android.gms"

    invoke-virtual {v2, v5}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 115
    invoke-virtual {v0, v2, v3}, Landroid/content/pm/PackageManager;->queryIntentServices(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v5

    .line 116
    .local v5, "infos":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    if-eqz v5, :cond_2

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v6

    if-lez v6, :cond_2

    .line 117
    iput v4, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I

    .line 118
    iget v3, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return v3

    .line 122
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v5    # "infos":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    :cond_2
    :try_start_3
    new-instance v2, Landroid/content/Intent;

    const-string v5, "com.google.iid.TOKEN_REQUEST"

    invoke-direct {v2, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 123
    .restart local v2    # "intent":Landroid/content/Intent;
    const-string v5, "com.google.android.gms"

    invoke-virtual {v2, v5}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 124
    invoke-virtual {v0, v2, v3}, Landroid/content/pm/PackageManager;->queryBroadcastReceivers(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v3

    .line 125
    .local v3, "infos":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    const/4 v5, 0x2

    if-eqz v3, :cond_3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v6

    if-lez v6, :cond_3

    .line 126
    iput v5, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I

    .line 127
    iget v4, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    monitor-exit p0

    return v4

    .line 130
    :cond_3
    :try_start_4
    const-string v6, "FirebaseMessaging"

    const-string v7, "Failed to resolve IID implementation package, falling back"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 132
    invoke-static {}, Lcom/google/android/gms/common/util/PlatformVersion;->isAtLeastO()Z

    move-result v6

    if-eqz v6, :cond_4

    .line 133
    iput v5, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I

    goto :goto_0

    .line 135
    :cond_4
    iput v4, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I

    .line 137
    :goto_0
    iget v4, p0, Lcom/google/firebase/messaging/Metadata;->iidImplementation:I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    monitor-exit p0

    return v4

    .line 95
    .end local v0    # "pm":Landroid/content/pm/PackageManager;
    .end local v1    # "permissionState":I
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "infos":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    :catchall_0
    move-exception v0

    :try_start_5
    monitor-exit p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0
.end method

.method isGmscorePresent()Z
    .locals 1

    .line 77
    invoke-virtual {p0}, Lcom/google/firebase/messaging/Metadata;->getIidImplementation()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
