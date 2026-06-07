.class Landroidx/core/app/NotificationCompatJellybean;
.super Ljava/lang/Object;
.source "NotificationCompatJellybean.java"


# static fields
.field static final EXTRA_ALLOW_GENERATED_REPLIES:Ljava/lang/String; = "android.support.allowGeneratedReplies"

.field static final EXTRA_DATA_ONLY_REMOTE_INPUTS:Ljava/lang/String; = "android.support.dataRemoteInputs"

.field private static final KEY_ACTION_INTENT:Ljava/lang/String; = "actionIntent"

.field private static final KEY_ALLOWED_DATA_TYPES:Ljava/lang/String; = "allowedDataTypes"

.field private static final KEY_ALLOW_FREE_FORM_INPUT:Ljava/lang/String; = "allowFreeFormInput"

.field private static final KEY_CHOICES:Ljava/lang/String; = "choices"

.field private static final KEY_DATA_ONLY_REMOTE_INPUTS:Ljava/lang/String; = "dataOnlyRemoteInputs"

.field private static final KEY_EXTRAS:Ljava/lang/String; = "extras"

.field private static final KEY_ICON:Ljava/lang/String; = "icon"

.field private static final KEY_LABEL:Ljava/lang/String; = "label"

.field private static final KEY_REMOTE_INPUTS:Ljava/lang/String; = "remoteInputs"

.field private static final KEY_RESULT_KEY:Ljava/lang/String; = "resultKey"

.field private static final KEY_SEMANTIC_ACTION:Ljava/lang/String; = "semanticAction"

.field private static final KEY_SHOWS_USER_INTERFACE:Ljava/lang/String; = "showsUserInterface"

.field private static final KEY_TITLE:Ljava/lang/String; = "title"

.field public static final TAG:Ljava/lang/String; = "NotificationCompat"

.field private static sActionIconField:Ljava/lang/reflect/Field;

.field private static sActionIntentField:Ljava/lang/reflect/Field;

.field private static sActionTitleField:Ljava/lang/reflect/Field;

.field private static sActionsAccessFailed:Z

.field private static sActionsField:Ljava/lang/reflect/Field;

.field private static final sActionsLock:Ljava/lang/Object;

.field private static sExtrasField:Ljava/lang/reflect/Field;

.field private static sExtrasFieldAccessFailed:Z

.field private static final sExtrasLock:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 58
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Landroidx/core/app/NotificationCompatJellybean;->sExtrasLock:Ljava/lang/Object;

    .line 62
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Landroidx/core/app/NotificationCompatJellybean;->sActionsLock:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 343
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 344
    return-void
.end method

.method public static buildActionExtrasMap(Ljava/util/List;)Landroid/util/SparseArray;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/os/Bundle;",
            ">;)",
            "Landroid/util/SparseArray<",
            "Landroid/os/Bundle;",
            ">;"
        }
    .end annotation

    .line 71
    .local p0, "actionExtrasList":Ljava/util/List;, "Ljava/util/List<Landroid/os/Bundle;>;"
    const/4 v0, 0x0

    .line 72
    .local v0, "actionExtrasMap":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Landroid/os/Bundle;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    .local v2, "count":I
    :goto_0
    if-ge v1, v2, :cond_2

    .line 73
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/os/Bundle;

    .line 74
    .local v3, "actionExtras":Landroid/os/Bundle;
    if-eqz v3, :cond_1

    .line 75
    if-nez v0, :cond_0

    .line 76
    new-instance v4, Landroid/util/SparseArray;

    invoke-direct {v4}, Landroid/util/SparseArray;-><init>()V

    move-object v0, v4

    .line 78
    :cond_0
    invoke-virtual {v0, v1, v3}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 72
    .end local v3    # "actionExtras":Landroid/os/Bundle;
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 81
    .end local v1    # "i":I
    .end local v2    # "count":I
    :cond_2
    return-object v0
.end method

.method private static ensureActionReflectionReadyLocked()Z
    .locals 6

    .line 207
    const-string v0, "Unable to access notification actions"

    const-string v1, "NotificationCompat"

    sget-boolean v2, Landroidx/core/app/NotificationCompatJellybean;->sActionsAccessFailed:Z

    if-eqz v2, :cond_0

    .line 208
    const/4 v0, 0x0

    return v0

    .line 211
    :cond_0
    const/4 v2, 0x1

    :try_start_0
    sget-object v3, Landroidx/core/app/NotificationCompatJellybean;->sActionsField:Ljava/lang/reflect/Field;

    if-nez v3, :cond_1

    .line 212
    const-string v3, "android.app.Notification$Action"

    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    .line 213
    .local v3, "sActionClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v4, "icon"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    sput-object v4, Landroidx/core/app/NotificationCompatJellybean;->sActionIconField:Ljava/lang/reflect/Field;

    .line 214
    const-string v4, "title"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    sput-object v4, Landroidx/core/app/NotificationCompatJellybean;->sActionTitleField:Ljava/lang/reflect/Field;

    .line 215
    const-string v4, "actionIntent"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    sput-object v4, Landroidx/core/app/NotificationCompatJellybean;->sActionIntentField:Ljava/lang/reflect/Field;

    .line 216
    const-class v4, Landroid/app/Notification;

    const-string v5, "actions"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    sput-object v4, Landroidx/core/app/NotificationCompatJellybean;->sActionsField:Ljava/lang/reflect/Field;

    .line 217
    sget-object v4, Landroidx/core/app/NotificationCompatJellybean;->sActionsField:Ljava/lang/reflect/Field;

    invoke-virtual {v4, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 222
    .end local v3    # "sActionClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_0
    move-exception v3

    .line 223
    .local v3, "e":Ljava/lang/NoSuchFieldException;
    invoke-static {v1, v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 224
    sput-boolean v2, Landroidx/core/app/NotificationCompatJellybean;->sActionsAccessFailed:Z

    goto :goto_1

    .line 219
    .end local v3    # "e":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v3

    .line 220
    .local v3, "e":Ljava/lang/ClassNotFoundException;
    invoke-static {v1, v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 221
    sput-boolean v2, Landroidx/core/app/NotificationCompatJellybean;->sActionsAccessFailed:Z

    .line 225
    .end local v3    # "e":Ljava/lang/ClassNotFoundException;
    :cond_1
    :goto_0
    nop

    .line 226
    :goto_1
    sget-boolean v0, Landroidx/core/app/NotificationCompatJellybean;->sActionsAccessFailed:Z

    xor-int/2addr v0, v2

    return v0
.end method

.method private static fromBundle(Landroid/os/Bundle;)Landroidx/core/app/RemoteInput;
    .locals 10
    .param p0, "data"    # Landroid/os/Bundle;

    .line 270
    const-string v0, "allowedDataTypes"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    .line 271
    .local v0, "allowedDataTypesAsList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    move-object v9, v1

    .line 272
    .local v9, "allowedDataTypes":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    if-eqz v0, :cond_0

    .line 273
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 274
    .local v2, "type":Ljava/lang/String;
    invoke-interface {v9, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 275
    .end local v2    # "type":Ljava/lang/String;
    goto :goto_0

    .line 277
    :cond_0
    new-instance v2, Landroidx/core/app/RemoteInput;

    const-string v1, "resultKey"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 278
    const-string v1, "label"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v4

    .line 279
    const-string v1, "choices"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getCharSequenceArray(Ljava/lang/String;)[Ljava/lang/CharSequence;

    move-result-object v5

    .line 280
    const-string v1, "allowFreeFormInput"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v6

    .line 282
    const-string v1, "extras"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v8

    const/4 v7, 0x0

    invoke-direct/range {v2 .. v9}, Landroidx/core/app/RemoteInput;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;[Ljava/lang/CharSequence;ZILandroid/os/Bundle;Ljava/util/Set;)V

    .line 277
    return-object v2
.end method

.method private static fromBundleArray([Landroid/os/Bundle;)[Landroidx/core/app/RemoteInput;
    .locals 3
    .param p0, "bundles"    # [Landroid/os/Bundle;

    .line 306
    if-nez p0, :cond_0

    .line 307
    const/4 v0, 0x0

    return-object v0

    .line 309
    :cond_0
    array-length v0, p0

    new-array v0, v0, [Landroidx/core/app/RemoteInput;

    .line 310
    .local v0, "remoteInputs":[Landroidx/core/app/RemoteInput;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_1

    .line 311
    aget-object v2, p0, v1

    invoke-static {v2}, Landroidx/core/app/NotificationCompatJellybean;->fromBundle(Landroid/os/Bundle;)Landroidx/core/app/RemoteInput;

    move-result-object v2

    aput-object v2, v0, v1

    .line 310
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 313
    .end local v1    # "i":I
    :cond_1
    return-object v0
.end method

.method public static getAction(Landroid/app/Notification;I)Landroidx/core/app/NotificationCompat$Action;
    .locals 8
    .param p0, "notif"    # Landroid/app/Notification;
    .param p1, "actionIndex"    # I

    .line 163
    sget-object v0, Landroidx/core/app/NotificationCompatJellybean;->sActionsLock:Ljava/lang/Object;

    monitor-enter v0

    .line 165
    :try_start_0
    invoke-static {p0}, Landroidx/core/app/NotificationCompatJellybean;->getActionObjectsLocked(Landroid/app/Notification;)[Ljava/lang/Object;

    move-result-object v1

    .line 166
    .local v1, "actionObjects":[Ljava/lang/Object;
    if-eqz v1, :cond_1

    .line 167
    aget-object v2, v1, p1

    .line 168
    .local v2, "actionObject":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 169
    .local v3, "actionExtras":Landroid/os/Bundle;
    invoke-static {p0}, Landroidx/core/app/NotificationCompatJellybean;->getExtras(Landroid/app/Notification;)Landroid/os/Bundle;

    move-result-object v4

    .line 170
    .local v4, "extras":Landroid/os/Bundle;
    if-eqz v4, :cond_0

    .line 171
    const-string v5, "android.support.actionExtras"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->getSparseParcelableArray(Ljava/lang/String;)Landroid/util/SparseArray;

    move-result-object v5

    .line 173
    .local v5, "actionExtrasMap":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Landroid/os/Bundle;>;"
    if-eqz v5, :cond_0

    .line 174
    invoke-virtual {v5, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/os/Bundle;

    move-object v3, v6

    .line 177
    .end local v5    # "actionExtrasMap":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Landroid/os/Bundle;>;"
    :cond_0
    sget-object v5, Landroidx/core/app/NotificationCompatJellybean;->sActionIconField:Ljava/lang/reflect/Field;

    invoke-virtual {v5, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v5

    sget-object v6, Landroidx/core/app/NotificationCompatJellybean;->sActionTitleField:Ljava/lang/reflect/Field;

    .line 178
    invoke-virtual {v6, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    sget-object v7, Landroidx/core/app/NotificationCompatJellybean;->sActionIntentField:Ljava/lang/reflect/Field;

    .line 179
    invoke-virtual {v7, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/app/PendingIntent;

    .line 177
    invoke-static {v5, v6, v7, v3}, Landroidx/core/app/NotificationCompatJellybean;->readAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;Landroid/os/Bundle;)Landroidx/core/app/NotificationCompat$Action;

    move-result-object v5
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    monitor-exit v0

    return-object v5

    .line 185
    .end local v1    # "actionObjects":[Ljava/lang/Object;
    .end local v2    # "actionObject":Ljava/lang/Object;
    .end local v3    # "actionExtras":Landroid/os/Bundle;
    .end local v4    # "extras":Landroid/os/Bundle;
    :cond_1
    goto :goto_0

    .line 186
    :catchall_0
    move-exception v1

    goto :goto_1

    .line 182
    :catch_0
    move-exception v1

    .line 183
    .local v1, "e":Ljava/lang/IllegalAccessException;
    const-string v2, "NotificationCompat"

    const-string v3, "Unable to access notification actions"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 184
    const/4 v2, 0x1

    sput-boolean v2, Landroidx/core/app/NotificationCompatJellybean;->sActionsAccessFailed:Z

    .line 186
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :goto_0
    monitor-exit v0

    .line 187
    const/4 v0, 0x0

    return-object v0

    .line 186
    :goto_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static getActionCount(Landroid/app/Notification;)I
    .locals 3
    .param p0, "notif"    # Landroid/app/Notification;

    .line 156
    sget-object v0, Landroidx/core/app/NotificationCompatJellybean;->sActionsLock:Ljava/lang/Object;

    monitor-enter v0

    .line 157
    :try_start_0
    invoke-static {p0}, Landroidx/core/app/NotificationCompatJellybean;->getActionObjectsLocked(Landroid/app/Notification;)[Ljava/lang/Object;

    move-result-object v1

    .line 158
    .local v1, "actionObjects":[Ljava/lang/Object;
    if-eqz v1, :cond_0

    array-length v2, v1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    monitor-exit v0

    return v2

    .line 159
    .end local v1    # "actionObjects":[Ljava/lang/Object;
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method static getActionFromBundle(Landroid/os/Bundle;)Landroidx/core/app/NotificationCompat$Action;
    .locals 14
    .param p0, "bundle"    # Landroid/os/Bundle;

    .line 230
    const-string v0, "extras"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v1

    .line 231
    .local v1, "extras":Landroid/os/Bundle;
    const/4 v2, 0x0

    .line 232
    .local v2, "allowGeneratedReplies":Z
    if-eqz v1, :cond_0

    .line 233
    const-string v3, "android.support.allowGeneratedReplies"

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    move v10, v2

    goto :goto_0

    .line 232
    :cond_0
    move v10, v2

    .line 235
    .end local v2    # "allowGeneratedReplies":Z
    .local v10, "allowGeneratedReplies":Z
    :goto_0
    new-instance v3, Landroidx/core/app/NotificationCompat$Action;

    .line 236
    const-string v2, "icon"

    invoke-virtual {p0, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v4

    .line 237
    const-string v2, "title"

    invoke-virtual {p0, v2}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v5

    .line 238
    const-string v2, "actionIntent"

    invoke-virtual {p0, v2}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v2

    move-object v6, v2

    check-cast v6, Landroid/app/PendingIntent;

    .line 239
    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v7

    .line 240
    const-string v0, "remoteInputs"

    invoke-static {p0, v0}, Landroidx/core/app/NotificationCompatJellybean;->getBundleArrayFromBundle(Landroid/os/Bundle;Ljava/lang/String;)[Landroid/os/Bundle;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/app/NotificationCompatJellybean;->fromBundleArray([Landroid/os/Bundle;)[Landroidx/core/app/RemoteInput;

    move-result-object v8

    .line 241
    const-string v0, "dataOnlyRemoteInputs"

    invoke-static {p0, v0}, Landroidx/core/app/NotificationCompatJellybean;->getBundleArrayFromBundle(Landroid/os/Bundle;Ljava/lang/String;)[Landroid/os/Bundle;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/app/NotificationCompatJellybean;->fromBundleArray([Landroid/os/Bundle;)[Landroidx/core/app/RemoteInput;

    move-result-object v9

    .line 243
    const-string v0, "semanticAction"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v11

    .line 244
    const-string v0, "showsUserInterface"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v12

    const/4 v13, 0x0

    invoke-direct/range {v3 .. v13}, Landroidx/core/app/NotificationCompat$Action;-><init>(ILjava/lang/CharSequence;Landroid/app/PendingIntent;Landroid/os/Bundle;[Landroidx/core/app/RemoteInput;[Landroidx/core/app/RemoteInput;ZIZZ)V

    .line 235
    return-object v3
.end method

.method private static getActionObjectsLocked(Landroid/app/Notification;)[Ljava/lang/Object;
    .locals 5
    .param p0, "notif"    # Landroid/app/Notification;

    .line 191
    sget-object v0, Landroidx/core/app/NotificationCompatJellybean;->sActionsLock:Ljava/lang/Object;

    monitor-enter v0

    .line 192
    :try_start_0
    invoke-static {}, Landroidx/core/app/NotificationCompatJellybean;->ensureActionReflectionReadyLocked()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 193
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v2

    .line 196
    :cond_0
    :try_start_1
    sget-object v1, Landroidx/core/app/NotificationCompatJellybean;->sActionsField:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Object;

    check-cast v1, [Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    monitor-exit v0

    return-object v1

    .line 197
    :catch_0
    move-exception v1

    .line 198
    .local v1, "e":Ljava/lang/IllegalAccessException;
    const-string v3, "NotificationCompat"

    const-string v4, "Unable to access notification actions"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 199
    const/4 v3, 0x1

    sput-boolean v3, Landroidx/core/app/NotificationCompatJellybean;->sActionsAccessFailed:Z

    .line 200
    monitor-exit v0

    return-object v2

    .line 202
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method private static getBundleArrayFromBundle(Landroid/os/Bundle;Ljava/lang/String;)[Landroid/os/Bundle;
    .locals 3
    .param p0, "bundle"    # Landroid/os/Bundle;
    .param p1, "key"    # Ljava/lang/String;

    .line 333
    invoke-virtual {p0, p1}, Landroid/os/Bundle;->getParcelableArray(Ljava/lang/String;)[Landroid/os/Parcelable;

    move-result-object v0

    .line 334
    .local v0, "array":[Landroid/os/Parcelable;
    instance-of v1, v0, [Landroid/os/Bundle;

    if-nez v1, :cond_1

    if-nez v0, :cond_0

    goto :goto_0

    .line 337
    :cond_0
    array-length v1, v0

    const-class v2, [Landroid/os/Bundle;

    invoke-static {v0, v1, v2}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;ILjava/lang/Class;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroid/os/Bundle;

    .line 339
    .local v1, "typedArray":[Landroid/os/Bundle;
    invoke-virtual {p0, p1, v1}, Landroid/os/Bundle;->putParcelableArray(Ljava/lang/String;[Landroid/os/Parcelable;)V

    .line 340
    return-object v1

    .line 335
    .end local v1    # "typedArray":[Landroid/os/Bundle;
    :cond_1
    :goto_0
    move-object v1, v0

    check-cast v1, [Landroid/os/Bundle;

    check-cast v1, [Landroid/os/Bundle;

    return-object v1
.end method

.method static getBundleForAction(Landroidx/core/app/NotificationCompat$Action;)Landroid/os/Bundle;
    .locals 4
    .param p0, "action"    # Landroidx/core/app/NotificationCompat$Action;

    .line 249
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 250
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v1, "icon"

    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getIcon()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 251
    const-string v1, "title"

    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getTitle()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    .line 252
    const-string v1, "actionIntent"

    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getActionIntent()Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 254
    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 255
    new-instance v1, Landroid/os/Bundle;

    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Bundle;-><init>(Landroid/os/Bundle;)V

    .local v1, "actionExtras":Landroid/os/Bundle;
    goto :goto_0

    .line 257
    .end local v1    # "actionExtras":Landroid/os/Bundle;
    :cond_0
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 259
    .restart local v1    # "actionExtras":Landroid/os/Bundle;
    :goto_0
    nop

    .line 260
    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getAllowGeneratedReplies()Z

    move-result v2

    .line 259
    const-string v3, "android.support.allowGeneratedReplies"

    invoke-virtual {v1, v3, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 261
    const-string v2, "extras"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 262
    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v2

    invoke-static {v2}, Landroidx/core/app/NotificationCompatJellybean;->toBundleArray([Landroidx/core/app/RemoteInput;)[Landroid/os/Bundle;

    move-result-object v2

    const-string v3, "remoteInputs"

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putParcelableArray(Ljava/lang/String;[Landroid/os/Parcelable;)V

    .line 263
    const-string v2, "showsUserInterface"

    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getShowsUserInterface()Z

    move-result v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 264
    const-string v2, "semanticAction"

    invoke-virtual {p0}, Landroidx/core/app/NotificationCompat$Action;->getSemanticAction()I

    move-result v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 265
    return-object v0
.end method

.method public static getExtras(Landroid/app/Notification;)Landroid/os/Bundle;
    .locals 6
    .param p0, "notif"    # Landroid/app/Notification;

    .line 89
    sget-object v0, Landroidx/core/app/NotificationCompatJellybean;->sExtrasLock:Ljava/lang/Object;

    monitor-enter v0

    .line 90
    :try_start_0
    sget-boolean v1, Landroidx/core/app/NotificationCompatJellybean;->sExtrasFieldAccessFailed:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 91
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v2

    .line 94
    :cond_0
    const/4 v1, 0x1

    :try_start_1
    sget-object v3, Landroidx/core/app/NotificationCompatJellybean;->sExtrasField:Ljava/lang/reflect/Field;

    if-nez v3, :cond_2

    .line 95
    const-class v3, Landroid/app/Notification;

    const-string v4, "extras"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    .line 96
    .local v3, "extrasField":Ljava/lang/reflect/Field;
    const-class v4, Landroid/os/Bundle;

    invoke-virtual {v3}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 97
    const-string v4, "NotificationCompat"

    const-string v5, "Notification.extras field is not of type Bundle"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 98
    sput-boolean v1, Landroidx/core/app/NotificationCompatJellybean;->sExtrasFieldAccessFailed:Z
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/NoSuchFieldException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 99
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    return-object v2

    .line 101
    :cond_1
    :try_start_3
    invoke-virtual {v3, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 102
    sput-object v3, Landroidx/core/app/NotificationCompatJellybean;->sExtrasField:Ljava/lang/reflect/Field;

    .line 104
    .end local v3    # "extrasField":Ljava/lang/reflect/Field;
    :cond_2
    sget-object v3, Landroidx/core/app/NotificationCompatJellybean;->sExtrasField:Ljava/lang/reflect/Field;

    invoke-virtual {v3, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/os/Bundle;

    .line 105
    .local v3, "extras":Landroid/os/Bundle;
    if-nez v3, :cond_3

    .line 106
    new-instance v4, Landroid/os/Bundle;

    invoke-direct {v4}, Landroid/os/Bundle;-><init>()V

    move-object v3, v4

    .line 107
    sget-object v4, Landroidx/core/app/NotificationCompatJellybean;->sExtrasField:Ljava/lang/reflect/Field;

    invoke-virtual {v4, p0, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/NoSuchFieldException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 109
    :cond_3
    :try_start_4
    monitor-exit v0

    return-object v3

    .line 112
    .end local v3    # "extras":Landroid/os/Bundle;
    :catch_0
    move-exception v3

    .line 113
    .local v3, "e":Ljava/lang/NoSuchFieldException;
    const-string v4, "NotificationCompat"

    const-string v5, "Unable to access notification extras"

    invoke-static {v4, v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 110
    .end local v3    # "e":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v3

    .line 111
    .local v3, "e":Ljava/lang/IllegalAccessException;
    const-string v4, "NotificationCompat"

    const-string v5, "Unable to access notification extras"

    invoke-static {v4, v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 114
    nop

    .line 115
    .end local v3    # "e":Ljava/lang/IllegalAccessException;
    :goto_0
    sput-boolean v1, Landroidx/core/app/NotificationCompatJellybean;->sExtrasFieldAccessFailed:Z

    .line 116
    monitor-exit v0

    return-object v2

    .line 117
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v1
.end method

.method public static readAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;Landroid/os/Bundle;)Landroidx/core/app/NotificationCompat$Action;
    .locals 11
    .param p0, "icon"    # I
    .param p1, "title"    # Ljava/lang/CharSequence;
    .param p2, "actionIntent"    # Landroid/app/PendingIntent;
    .param p3, "extras"    # Landroid/os/Bundle;

    .line 122
    const/4 v0, 0x0

    .line 123
    .local v0, "remoteInputs":[Landroidx/core/app/RemoteInput;
    const/4 v1, 0x0

    .line 124
    .local v1, "dataOnlyRemoteInputs":[Landroidx/core/app/RemoteInput;
    const/4 v2, 0x0

    .line 125
    .local v2, "allowGeneratedReplies":Z
    if-eqz p3, :cond_0

    .line 126
    nop

    .line 127
    const-string v3, "android.support.remoteInputs"

    invoke-static {p3, v3}, Landroidx/core/app/NotificationCompatJellybean;->getBundleArrayFromBundle(Landroid/os/Bundle;Ljava/lang/String;)[Landroid/os/Bundle;

    move-result-object v3

    .line 126
    invoke-static {v3}, Landroidx/core/app/NotificationCompatJellybean;->fromBundleArray([Landroid/os/Bundle;)[Landroidx/core/app/RemoteInput;

    move-result-object v0

    .line 129
    nop

    .line 130
    const-string v3, "android.support.dataRemoteInputs"

    invoke-static {p3, v3}, Landroidx/core/app/NotificationCompatJellybean;->getBundleArrayFromBundle(Landroid/os/Bundle;Ljava/lang/String;)[Landroid/os/Bundle;

    move-result-object v3

    .line 129
    invoke-static {v3}, Landroidx/core/app/NotificationCompatJellybean;->fromBundleArray([Landroid/os/Bundle;)[Landroidx/core/app/RemoteInput;

    move-result-object v1

    .line 131
    const-string v3, "android.support.allowGeneratedReplies"

    invoke-virtual {p3, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    move-object v5, v0

    move-object v6, v1

    move v7, v2

    goto :goto_0

    .line 125
    :cond_0
    move-object v5, v0

    move-object v6, v1

    move v7, v2

    .line 133
    .end local v0    # "remoteInputs":[Landroidx/core/app/RemoteInput;
    .end local v1    # "dataOnlyRemoteInputs":[Landroidx/core/app/RemoteInput;
    .end local v2    # "allowGeneratedReplies":Z
    .local v5, "remoteInputs":[Landroidx/core/app/RemoteInput;
    .local v6, "dataOnlyRemoteInputs":[Landroidx/core/app/RemoteInput;
    .local v7, "allowGeneratedReplies":Z
    :goto_0
    new-instance v0, Landroidx/core/app/NotificationCompat$Action;

    const/4 v9, 0x1

    const/4 v10, 0x0

    const/4 v8, 0x0

    move v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-direct/range {v0 .. v10}, Landroidx/core/app/NotificationCompat$Action;-><init>(ILjava/lang/CharSequence;Landroid/app/PendingIntent;Landroid/os/Bundle;[Landroidx/core/app/RemoteInput;[Landroidx/core/app/RemoteInput;ZIZZ)V

    return-object v0
.end method

.method private static toBundle(Landroidx/core/app/RemoteInput;)Landroid/os/Bundle;
    .locals 5
    .param p0, "remoteInput"    # Landroidx/core/app/RemoteInput;

    .line 287
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 288
    .local v0, "data":Landroid/os/Bundle;
    const-string v1, "resultKey"

    invoke-virtual {p0}, Landroidx/core/app/RemoteInput;->getResultKey()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 289
    const-string v1, "label"

    invoke-virtual {p0}, Landroidx/core/app/RemoteInput;->getLabel()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    .line 290
    const-string v1, "choices"

    invoke-virtual {p0}, Landroidx/core/app/RemoteInput;->getChoices()[Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putCharSequenceArray(Ljava/lang/String;[Ljava/lang/CharSequence;)V

    .line 291
    const-string v1, "allowFreeFormInput"

    invoke-virtual {p0}, Landroidx/core/app/RemoteInput;->getAllowFreeFormInput()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 292
    const-string v1, "extras"

    invoke-virtual {p0}, Landroidx/core/app/RemoteInput;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 294
    invoke-virtual {p0}, Landroidx/core/app/RemoteInput;->getAllowedDataTypes()Ljava/util/Set;

    move-result-object v1

    .line 295
    .local v1, "allowedDataTypes":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 296
    new-instance v2, Ljava/util/ArrayList;

    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 297
    .local v2, "allowedDataTypesAsList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 298
    .local v4, "type":Ljava/lang/String;
    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 299
    .end local v4    # "type":Ljava/lang/String;
    goto :goto_0

    .line 300
    :cond_0
    const-string v3, "allowedDataTypes"

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putStringArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    .line 302
    .end local v2    # "allowedDataTypesAsList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_1
    return-object v0
.end method

.method private static toBundleArray([Landroidx/core/app/RemoteInput;)[Landroid/os/Bundle;
    .locals 3
    .param p0, "remoteInputs"    # [Landroidx/core/app/RemoteInput;

    .line 317
    if-nez p0, :cond_0

    .line 318
    const/4 v0, 0x0

    return-object v0

    .line 320
    :cond_0
    array-length v0, p0

    new-array v0, v0, [Landroid/os/Bundle;

    .line 321
    .local v0, "bundles":[Landroid/os/Bundle;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_1

    .line 322
    aget-object v2, p0, v1

    invoke-static {v2}, Landroidx/core/app/NotificationCompatJellybean;->toBundle(Landroidx/core/app/RemoteInput;)Landroid/os/Bundle;

    move-result-object v2

    aput-object v2, v0, v1

    .line 321
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 324
    .end local v1    # "i":I
    :cond_1
    return-object v0
.end method

.method public static writeActionAndGetExtras(Landroid/app/Notification$Builder;Landroidx/core/app/NotificationCompat$Action;)Landroid/os/Bundle;
    .locals 3
    .param p0, "builder"    # Landroid/app/Notification$Builder;
    .param p1, "action"    # Landroidx/core/app/NotificationCompat$Action;

    .line 140
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getIcon()I

    move-result v0

    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getTitle()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getActionIntent()Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Landroid/app/Notification$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    .line 141
    new-instance v0, Landroid/os/Bundle;

    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Bundle;-><init>(Landroid/os/Bundle;)V

    .line 142
    .local v0, "actionExtras":Landroid/os/Bundle;
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 143
    nop

    .line 144
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v1

    invoke-static {v1}, Landroidx/core/app/NotificationCompatJellybean;->toBundleArray([Landroidx/core/app/RemoteInput;)[Landroid/os/Bundle;

    move-result-object v1

    .line 143
    const-string v2, "android.support.remoteInputs"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putParcelableArray(Ljava/lang/String;[Landroid/os/Parcelable;)V

    .line 146
    :cond_0
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getDataOnlyRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 147
    nop

    .line 148
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getDataOnlyRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v1

    invoke-static {v1}, Landroidx/core/app/NotificationCompatJellybean;->toBundleArray([Landroidx/core/app/RemoteInput;)[Landroid/os/Bundle;

    move-result-object v1

    .line 147
    const-string v2, "android.support.dataRemoteInputs"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putParcelableArray(Ljava/lang/String;[Landroid/os/Parcelable;)V

    .line 150
    :cond_1
    nop

    .line 151
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getAllowGeneratedReplies()Z

    move-result v1

    .line 150
    const-string v2, "android.support.allowGeneratedReplies"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 152
    return-object v0
.end method
