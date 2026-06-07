.class Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
.super Ljava/lang/Object;
.source "HeartBeatInfoStorage.java"


# static fields
.field private static final GLOBAL:Landroidx/datastore/preferences/core/Preferences$Key;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/datastore/preferences/core/Preferences$Key<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private static final HEARTBEAT_PREFERENCES_NAME:Ljava/lang/String; = "FirebaseHeartBeat"

.field private static final HEART_BEAT_COUNT_LIMIT:I = 0x1e

.field private static final HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/datastore/preferences/core/Preferences$Key<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private static final LAST_STORED_DATE:Landroidx/datastore/preferences/core/Preferences$Key;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/datastore/preferences/core/Preferences$Key<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final PREFERENCES_NAME:Ljava/lang/String; = "FirebaseAppHeartBeat"

.field private static instance:Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;


# instance fields
.field private final firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 45
    const/4 v0, 0x0

    sput-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->instance:Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;

    .line 47
    const-string v0, "fire-global"

    invoke-static {v0}, Landroidx/datastore/preferences/core/PreferencesKeys;->longKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v0

    sput-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->GLOBAL:Landroidx/datastore/preferences/core/Preferences$Key;

    .line 53
    nop

    .line 54
    const-string v0, "fire-count"

    invoke-static {v0}, Landroidx/datastore/preferences/core/PreferencesKeys;->longKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v0

    sput-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    .line 56
    nop

    .line 57
    const-string v0, "last-used-date"

    invoke-static {v0}, Landroidx/datastore/preferences/core/PreferencesKeys;->stringKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v0

    sput-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->LAST_STORED_DATE:Landroidx/datastore/preferences/core/Preferences$Key;

    .line 56
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3
    .param p1, "applicationContext"    # Landroid/content/Context;
    .param p2, "persistenceKey"    # Ljava/lang/String;

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    new-instance v0, Lcom/google/firebase/datastorage/JavaDataStorage;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FirebaseHeartBeat"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Lcom/google/firebase/datastorage/JavaDataStorage;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    .line 67
    return-void
.end method

.method constructor <init>(Lcom/google/firebase/datastorage/JavaDataStorage;)V
    .locals 0
    .param p1, "javaDataStorage"    # Lcom/google/firebase/datastorage/JavaDataStorage;

    .line 71
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    iput-object p1, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    .line 73
    return-void
.end method

.method private declared-synchronized cleanUpStoredHeartBeats(Landroidx/datastore/preferences/core/MutablePreferences;)J
    .locals 11
    .param p1, "preferences"    # Landroidx/datastore/preferences/core/MutablePreferences;

    monitor-enter p0

    .line 230
    :try_start_0
    sget-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    const-wide/16 v1, 0x0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/google/firebase/datastorage/JavaDataStorageKt;->getOrDefault(Landroidx/datastore/preferences/core/Preferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    .line 232
    .local v0, "heartBeatCount":J
    const/4 v2, 0x0

    .line 233
    .local v2, "lowestDate":Ljava/lang/String;
    const-string v3, ""

    .line 234
    .local v3, "userAgentString":Ljava/lang/String;
    new-instance v4, Ljava/util/HashSet;

    invoke-direct {v4}, Ljava/util/HashSet;-><init>()V

    .line 235
    .local v4, "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-virtual {p1}, Landroidx/datastore/preferences/core/MutablePreferences;->asMap()Ljava/util/Map;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    .line 236
    .local v6, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    instance-of v7, v7, Ljava/util/Set;

    if-eqz v7, :cond_2

    .line 237
    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Set;

    .line 238
    .local v7, "dateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_2

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 239
    .local v9, "date":Ljava/lang/String;
    if-eqz v2, :cond_0

    invoke-virtual {v2, v9}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v10

    if-lez v10, :cond_1

    .line 240
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :cond_0
    move-object v4, v7

    .line 241
    move-object v2, v9

    .line 242
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {v10}, Landroidx/datastore/preferences/core/Preferences$Key;->getName()Ljava/lang/String;

    move-result-object v10

    move-object v3, v10

    .line 244
    .end local v9    # "date":Ljava/lang/String;
    :cond_1
    goto :goto_1

    .line 246
    .end local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    .end local v7    # "dateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    :cond_2
    goto :goto_0

    .line 247
    :cond_3
    new-instance v5, Ljava/util/HashSet;

    invoke-direct {v5, v4}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 248
    .end local v4    # "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .local v5, "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v5, v2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 249
    invoke-static {v3}, Landroidx/datastore/preferences/core/PreferencesKeys;->stringSetKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v4

    invoke-virtual {p1, v4, v5}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 250
    sget-object v4, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    const-wide/16 v6, 0x1

    sub-long v8, v0, v6

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v8

    invoke-virtual {p1, v4, v8}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 252
    sub-long v6, v0, v6

    monitor-exit p0

    return-wide v6

    .line 229
    .end local v0    # "heartBeatCount":J
    .end local v2    # "lowestDate":Ljava/lang/String;
    .end local v3    # "userAgentString":Ljava/lang/String;
    .end local v5    # "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local p1    # "preferences":Landroidx/datastore/preferences/core/MutablePreferences;
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method private declared-synchronized getFormattedDate(J)Ljava/lang/String;
    .locals 3
    .param p1, "millis"    # J

    monitor-enter p0

    .line 183
    nop

    .line 184
    :try_start_0
    new-instance v0, Ljava/util/Date;

    invoke-direct {v0, p1, p2}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0}, Ljava/util/Date;->toInstant()Ljava/time/Instant;

    move-result-object v0

    .line 185
    .local v0, "instant":Ljava/time/Instant;
    sget-object v1, Ljava/time/ZoneOffset;->UTC:Ljava/time/ZoneOffset;

    invoke-virtual {v0, v1}, Ljava/time/Instant;->atOffset(Ljava/time/ZoneOffset;)Ljava/time/OffsetDateTime;

    move-result-object v1

    invoke-virtual {v1}, Ljava/time/OffsetDateTime;->toLocalDateTime()Ljava/time/LocalDateTime;

    move-result-object v1

    .line 186
    .local v1, "ldt":Ljava/time/LocalDateTime;
    sget-object v2, Ljava/time/format/DateTimeFormatter;->ISO_LOCAL_DATE:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v1, v2}, Ljava/time/LocalDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v2

    .line 182
    .end local v0    # "instant":Ljava/time/Instant;
    .end local v1    # "ldt":Ljava/time/LocalDateTime;
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "millis":J
    :goto_0
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    :catchall_0
    move-exception p1

    goto :goto_0
.end method

.method private declared-synchronized getStoredUserAgentString(Landroidx/datastore/preferences/core/MutablePreferences;Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;
    .locals 6
    .param p1, "preferences"    # Landroidx/datastore/preferences/core/MutablePreferences;
    .param p2, "dateString"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/datastore/preferences/core/MutablePreferences;",
            "Ljava/lang/String;",
            ")",
            "Landroidx/datastore/preferences/core/Preferences$Key<",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    monitor-enter p0

    .line 133
    :try_start_0
    invoke-virtual {p1}, Landroidx/datastore/preferences/core/MutablePreferences;->asMap()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 134
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    instance-of v2, v2, Ljava/util/Set;

    if-eqz v2, :cond_1

    .line 135
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Set;

    .line 136
    .local v2, "dateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 137
    .local v4, "date":Ljava/lang/String;
    invoke-virtual {p2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 138
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {v0}, Landroidx/datastore/preferences/core/Preferences$Key;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/datastore/preferences/core/PreferencesKeys;->stringSetKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 140
    .end local v4    # "date":Ljava/lang/String;
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :cond_0
    goto :goto_1

    .line 142
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    .end local v2    # "dateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    :cond_1
    goto :goto_0

    .line 143
    :cond_2
    monitor-exit p0

    const/4 v0, 0x0

    return-object v0

    .line 132
    .end local p1    # "preferences":Landroidx/datastore/preferences/core/MutablePreferences;
    .end local p2    # "dateString":Ljava/lang/String;
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method static synthetic lambda$updateGlobalHeartBeat$3(JLandroidx/datastore/preferences/core/MutablePreferences;)Lkotlin/Unit;
    .locals 2
    .param p0, "millis"    # J
    .param p2, "pref"    # Landroidx/datastore/preferences/core/MutablePreferences;

    .line 262
    sget-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->GLOBAL:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 263
    const/4 v0, 0x0

    return-object v0
.end method

.method private declared-synchronized removeStoredDate(Landroidx/datastore/preferences/core/MutablePreferences;Ljava/lang/String;)V
    .locals 3
    .param p1, "preferences"    # Landroidx/datastore/preferences/core/MutablePreferences;
    .param p2, "dateString"    # Ljava/lang/String;

    monitor-enter p0

    .line 157
    :try_start_0
    invoke-direct {p0, p1, p2}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getStoredUserAgentString(Landroidx/datastore/preferences/core/MutablePreferences;Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 158
    .local v0, "userAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    if-nez v0, :cond_0

    .line 159
    monitor-exit p0

    return-void

    .line 161
    :cond_0
    :try_start_1
    new-instance v1, Ljava/util/HashSet;

    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 162
    invoke-static {p1, v0, v2}, Lcom/google/firebase/datastorage/JavaDataStorageKt;->getOrDefault(Landroidx/datastore/preferences/core/Preferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Collection;

    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 163
    .local v1, "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v1, p2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 164
    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 165
    invoke-virtual {p1, v0}, Landroidx/datastore/preferences/core/MutablePreferences;->remove(Landroidx/datastore/preferences/core/Preferences$Key;)Ljava/lang/Object;

    goto :goto_0

    .line 167
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :cond_1
    invoke-virtual {p1, v0, v1}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 169
    :goto_0
    monitor-exit p0

    return-void

    .line 156
    .end local v0    # "userAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    .end local v1    # "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local p1    # "preferences":Landroidx/datastore/preferences/core/MutablePreferences;
    .end local p2    # "dateString":Ljava/lang/String;
    :catchall_0
    move-exception p1

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p1
.end method

.method private declared-synchronized updateStoredUserAgent(Landroidx/datastore/preferences/core/MutablePreferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/String;)V
    .locals 2
    .param p1, "preferences"    # Landroidx/datastore/preferences/core/MutablePreferences;
    .param p3, "dateString"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/datastore/preferences/core/MutablePreferences;",
            "Landroidx/datastore/preferences/core/Preferences$Key<",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;>;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .local p2, "userAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    monitor-enter p0

    .line 148
    :try_start_0
    invoke-direct {p0, p1, p3}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->removeStoredDate(Landroidx/datastore/preferences/core/MutablePreferences;Ljava/lang/String;)V

    .line 149
    new-instance v0, Ljava/util/HashSet;

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 150
    invoke-static {p1, p2, v1}, Lcom/google/firebase/datastorage/JavaDataStorageKt;->getOrDefault(Landroidx/datastore/preferences/core/Preferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Collection;

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 151
    .local v0, "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v0, p3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 152
    invoke-virtual {p1, p2, v0}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 153
    monitor-exit p0

    return-void

    .line 147
    .end local v0    # "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "preferences":Landroidx/datastore/preferences/core/MutablePreferences;
    .end local p2    # "userAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    .end local p3    # "dateString":Ljava/lang/String;
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method


# virtual methods
.method declared-synchronized deleteAllHeartBeats()V
    .locals 2

    monitor-enter p0

    .line 82
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    new-instance v1, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda3;-><init>(Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;)V

    invoke-virtual {v0, v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->editSync(Lkotlin/jvm/functions/Function1;)Landroidx/datastore/preferences/core/Preferences;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 108
    monitor-exit p0

    return-void

    .line 81
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method declared-synchronized getAllHeartBeats()Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/firebase/heartbeatinfo/HeartBeatResult;",
            ">;"
        }
    .end annotation

    monitor-enter p0

    .line 111
    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 112
    .local v0, "heartBeatResults":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/google/firebase/heartbeatinfo/HeartBeatResult;>;"
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {p0, v1, v2}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getFormattedDate(J)Ljava/lang/String;

    move-result-object v1

    .line 115
    .local v1, "today":Ljava/lang/String;
    iget-object v2, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-virtual {v2}, Lcom/google/firebase/datastorage/JavaDataStorage;->getAllSync()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 116
    .local v3, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    instance-of v4, v4, Ljava/util/Set;

    if-eqz v4, :cond_0

    .line 117
    new-instance v4, Ljava/util/HashSet;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Set;

    invoke-direct {v4, v5}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 118
    .local v4, "dates":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v4, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 119
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 120
    nop

    .line 121
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {v5}, Landroidx/datastore/preferences/core/Preferences$Key;->getName()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {v5, v6}, Lcom/google/firebase/heartbeatinfo/HeartBeatResult;->create(Ljava/lang/String;Ljava/util/List;)Lcom/google/firebase/heartbeatinfo/HeartBeatResult;

    move-result-object v5

    .line 120
    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 124
    .end local v3    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    .end local v4    # "dates":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :cond_0
    goto :goto_0

    .line 126
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p0, v2, v3}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->updateGlobalHeartBeat(J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 128
    monitor-exit p0

    return-object v0

    .line 110
    .end local v0    # "heartBeatResults":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/google/firebase/heartbeatinfo/HeartBeatResult;>;"
    .end local v1    # "today":Ljava/lang/String;
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method getHeartBeatCount()I
    .locals 4

    .line 78
    iget-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    sget-object v1, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    const-wide/16 v2, 0x0

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/firebase/datastorage/JavaDataStorage;->getSync(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->intValue()I

    move-result v0

    return v0
.end method

.method declared-synchronized getLastGlobalHeartBeat()J
    .locals 4

    monitor-enter p0

    .line 256
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    sget-object v1, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->GLOBAL:Landroidx/datastore/preferences/core/Preferences$Key;

    const-wide/16 v2, -0x1

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/firebase/datastorage/JavaDataStorage;->getSync(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-wide v0

    .line 256
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method declared-synchronized isSameDateUtc(JJ)Z
    .locals 2
    .param p1, "base"    # J
    .param p3, "target"    # J

    monitor-enter p0

    .line 268
    :try_start_0
    invoke-direct {p0, p1, p2}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getFormattedDate(J)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p3, p4}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getFormattedDate(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 268
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "base":J
    .end local p3    # "target":J
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method synthetic lambda$deleteAllHeartBeats$0$com-google-firebase-heartbeatinfo-HeartBeatInfoStorage(Landroidx/datastore/preferences/core/MutablePreferences;)Lkotlin/Unit;
    .locals 9
    .param p1, "pref"    # Landroidx/datastore/preferences/core/MutablePreferences;

    .line 84
    const-wide/16 v0, 0x0

    .line 85
    .local v0, "counter":J
    invoke-virtual {p1}, Landroidx/datastore/preferences/core/MutablePreferences;->asMap()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 86
    .local v3, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    instance-of v4, v4, Ljava/util/Set;

    if-eqz v4, :cond_1

    .line 88
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/datastore/preferences/core/Preferences$Key;

    .line 89
    .local v4, "key":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Set;

    .line 90
    .local v5, "dates":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-direct {p0, v6, v7}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getFormattedDate(J)Ljava/lang/String;

    move-result-object v6

    .line 92
    .local v6, "today":Ljava/lang/String;
    invoke-interface {v5, v6}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 93
    invoke-static {v6}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticBackport0;->m(Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v7

    invoke-virtual {p1, v4, v7}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 94
    const-wide/16 v7, 0x1

    add-long/2addr v0, v7

    goto :goto_1

    .line 96
    :cond_0
    invoke-virtual {p1, v4}, Landroidx/datastore/preferences/core/MutablePreferences;->remove(Landroidx/datastore/preferences/core/Preferences$Key;)Ljava/lang/Object;

    .line 99
    .end local v3    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Landroidx/datastore/preferences/core/Preferences$Key<*>;Ljava/lang/Object;>;"
    .end local v4    # "key":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    .end local v5    # "dates":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local v6    # "today":Ljava/lang/String;
    :cond_1
    :goto_1
    goto :goto_0

    .line 100
    :cond_2
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_3

    .line 101
    sget-object v2, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {p1, v2}, Landroidx/datastore/preferences/core/MutablePreferences;->remove(Landroidx/datastore/preferences/core/Preferences$Key;)Ljava/lang/Object;

    goto :goto_2

    .line 103
    :cond_3
    sget-object v2, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {p1, v2, v3}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 106
    :goto_2
    const/4 v2, 0x0

    return-object v2
.end method

.method synthetic lambda$postHeartBeatCleanUp$1$com-google-firebase-heartbeatinfo-HeartBeatInfoStorage(Ljava/lang/String;Landroidx/datastore/preferences/core/MutablePreferences;)Lkotlin/Unit;
    .locals 1
    .param p1, "dateString"    # Ljava/lang/String;
    .param p2, "pref"    # Landroidx/datastore/preferences/core/MutablePreferences;

    .line 176
    sget-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->LAST_STORED_DATE:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {p2, v0, p1}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 177
    invoke-direct {p0, p2, p1}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->removeStoredDate(Landroidx/datastore/preferences/core/MutablePreferences;Ljava/lang/String;)V

    .line 178
    const/4 v0, 0x0

    return-object v0
.end method

.method synthetic lambda$storeHeartBeat$2$com-google-firebase-heartbeatinfo-HeartBeatInfoStorage(Ljava/lang/String;Ljava/lang/String;Landroidx/datastore/preferences/core/Preferences$Key;Landroidx/datastore/preferences/core/MutablePreferences;)Lkotlin/Unit;
    .locals 11
    .param p1, "dateString"    # Ljava/lang/String;
    .param p2, "userAgentString"    # Ljava/lang/String;
    .param p3, "userAgent"    # Landroidx/datastore/preferences/core/Preferences$Key;
    .param p4, "pref"    # Landroidx/datastore/preferences/core/MutablePreferences;

    .line 197
    sget-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->LAST_STORED_DATE:Landroidx/datastore/preferences/core/Preferences$Key;

    const-string v1, ""

    invoke-static {p4, v0, v1}, Lcom/google/firebase/datastorage/JavaDataStorageKt;->getOrDefault(Landroidx/datastore/preferences/core/Preferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 198
    .local v0, "lastDateString":Ljava/lang/String;
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    .line 199
    nop

    .line 200
    invoke-direct {p0, p4, p1}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getStoredUserAgentString(Landroidx/datastore/preferences/core/MutablePreferences;Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v1

    .line 201
    .local v1, "storedUserAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    if-nez v1, :cond_0

    .line 203
    return-object v2

    .line 204
    :cond_0
    invoke-virtual {v1}, Landroidx/datastore/preferences/core/Preferences$Key;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 206
    return-object v2

    .line 208
    :cond_1
    invoke-direct {p0, p4, p3, p1}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->updateStoredUserAgent(Landroidx/datastore/preferences/core/MutablePreferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/String;)V

    .line 209
    return-object v2

    .line 212
    .end local v1    # "storedUserAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    :cond_2
    sget-object v1, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    const-wide/16 v3, 0x0

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-static {p4, v1, v3}, Lcom/google/firebase/datastorage/JavaDataStorageKt;->getOrDefault(Landroidx/datastore/preferences/core/Preferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    .line 213
    .local v3, "heartBeatCount":J
    const-wide/16 v5, 0x1

    add-long v7, v3, v5

    const-wide/16 v9, 0x1e

    cmp-long v1, v7, v9

    if-nez v1, :cond_3

    .line 214
    invoke-direct {p0, p4}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->cleanUpStoredHeartBeats(Landroidx/datastore/preferences/core/MutablePreferences;)J

    move-result-wide v3

    .line 216
    :cond_3
    new-instance v1, Ljava/util/HashSet;

    new-instance v7, Ljava/util/HashSet;

    invoke-direct {v7}, Ljava/util/HashSet;-><init>()V

    .line 217
    invoke-static {p4, p3, v7}, Lcom/google/firebase/datastorage/JavaDataStorageKt;->getOrDefault(Landroidx/datastore/preferences/core/Preferences;Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Collection;

    invoke-direct {v1, v7}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 218
    .local v1, "userAgentDateSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 219
    add-long/2addr v3, v5

    .line 221
    invoke-virtual {p4, p3, v1}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 222
    sget-object v5, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->HEART_BEAT_COUNT_TAG:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    invoke-virtual {p4, v5, v6}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 223
    sget-object v5, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->LAST_STORED_DATE:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {p4, v5, p1}, Landroidx/datastore/preferences/core/MutablePreferences;->set(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)V

    .line 225
    return-object v2
.end method

.method declared-synchronized postHeartBeatCleanUp()V
    .locals 3

    monitor-enter p0

    .line 172
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-direct {p0, v0, v1}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getFormattedDate(J)Ljava/lang/String;

    move-result-object v0

    .line 174
    .local v0, "dateString":Ljava/lang/String;
    iget-object v1, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    new-instance v2, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda4;

    invoke-direct {v2, p0, v0}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda4;-><init>(Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lcom/google/firebase/datastorage/JavaDataStorage;->editSync(Lkotlin/jvm/functions/Function1;)Landroidx/datastore/preferences/core/Preferences;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 180
    monitor-exit p0

    return-void

    .line 171
    .end local v0    # "dateString":Ljava/lang/String;
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method declared-synchronized shouldSendGlobalHeartBeat(J)Z
    .locals 1
    .param p1, "millis"    # J

    monitor-enter p0

    .line 290
    :try_start_0
    sget-object v0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->GLOBAL:Landroidx/datastore/preferences/core/Preferences$Key;

    invoke-virtual {p0, v0, p1, p2}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->shouldSendSdkHeartBeat(Landroidx/datastore/preferences/core/Preferences$Key;J)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 290
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "millis":J
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method declared-synchronized shouldSendSdkHeartBeat(Landroidx/datastore/preferences/core/Preferences$Key;J)Z
    .locals 3
    .param p2, "millis"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/datastore/preferences/core/Preferences$Key<",
            "Ljava/lang/Long;",
            ">;J)Z"
        }
    .end annotation

    .local p1, "heartBeatTag":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/lang/Long;>;"
    monitor-enter p0

    .line 277
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    const-wide/16 v1, -0x1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->getSync(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1, p2, p3}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->isSameDateUtc(JJ)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 278
    monitor-exit p0

    const/4 v0, 0x0

    return v0

    .line 280
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->putSync(Landroidx/datastore/preferences/core/Preferences$Key;Ljava/lang/Object;)Landroidx/datastore/preferences/core/Preferences;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 281
    monitor-exit p0

    const/4 v0, 0x1

    return v0

    .line 276
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "heartBeatTag":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/lang/Long;>;"
    .end local p2    # "millis":J
    :catchall_0
    move-exception p1

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p1
.end method

.method declared-synchronized storeHeartBeat(JLjava/lang/String;)V
    .locals 4
    .param p1, "millis"    # J
    .param p3, "userAgentString"    # Ljava/lang/String;

    monitor-enter p0

    .line 193
    :try_start_0
    invoke-direct {p0, p1, p2}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->getFormattedDate(J)Ljava/lang/String;

    move-result-object v0

    .line 194
    .local v0, "dateString":Ljava/lang/String;
    invoke-static {p3}, Landroidx/datastore/preferences/core/PreferencesKeys;->stringSetKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    move-result-object v1

    .line 195
    .local v1, "userAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    iget-object v2, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    new-instance v3, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda2;

    invoke-direct {v3, p0, v0, p3, v1}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda2;-><init>(Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;Ljava/lang/String;Ljava/lang/String;Landroidx/datastore/preferences/core/Preferences$Key;)V

    invoke-virtual {v2, v3}, Lcom/google/firebase/datastorage/JavaDataStorage;->editSync(Lkotlin/jvm/functions/Function1;)Landroidx/datastore/preferences/core/Preferences;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 227
    monitor-exit p0

    return-void

    .line 192
    .end local v0    # "dateString":Ljava/lang/String;
    .end local v1    # "userAgent":Landroidx/datastore/preferences/core/Preferences$Key;, "Landroidx/datastore/preferences/core/Preferences$Key<Ljava/util/Set<Ljava/lang/String;>;>;"
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "millis":J
    .end local p3    # "userAgentString":Ljava/lang/String;
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method declared-synchronized updateGlobalHeartBeat(J)V
    .locals 2
    .param p1, "millis"    # J

    monitor-enter p0

    .line 260
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;->firebaseDataStore:Lcom/google/firebase/datastorage/JavaDataStorage;

    new-instance v1, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda5;

    invoke-direct {v1, p1, p2}, Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage$$ExternalSyntheticLambda5;-><init>(J)V

    invoke-virtual {v0, v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->editSync(Lkotlin/jvm/functions/Function1;)Landroidx/datastore/preferences/core/Preferences;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 265
    monitor-exit p0

    return-void

    .line 259
    .end local p0    # "this":Lcom/google/firebase/heartbeatinfo/HeartBeatInfoStorage;
    .end local p1    # "millis":J
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method
