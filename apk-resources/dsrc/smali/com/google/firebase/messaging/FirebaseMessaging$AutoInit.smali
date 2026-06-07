.class Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;
.super Ljava/lang/Object;
.source "FirebaseMessaging.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/firebase/messaging/FirebaseMessaging;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "AutoInit"
.end annotation


# static fields
.field private static final AUTO_INIT_PREF:Ljava/lang/String; = "auto_init"

.field private static final FCM_PREFERENCES:Ljava/lang/String; = "com.google.firebase.messaging"

.field private static final MANIFEST_METADATA_AUTO_INIT_ENABLED:Ljava/lang/String; = "firebase_messaging_auto_init_enabled"


# instance fields
.field private autoInitEnabled:Ljava/lang/Boolean;

.field private dataCollectionDefaultChangeEventHandler:Lcom/google/firebase/events/EventHandler;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/firebase/events/EventHandler<",
            "Lcom/google/firebase/DataCollectionDefaultChange;",
            ">;"
        }
    .end annotation
.end field

.field private initialized:Z

.field private final subscriber:Lcom/google/firebase/events/Subscriber;

.field final synthetic this$0:Lcom/google/firebase/messaging/FirebaseMessaging;


# direct methods
.method constructor <init>(Lcom/google/firebase/messaging/FirebaseMessaging;Lcom/google/firebase/events/Subscriber;)V
    .locals 0
    .param p2, "subscriber"    # Lcom/google/firebase/events/Subscriber;

    .line 719
    iput-object p1, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->this$0:Lcom/google/firebase/messaging/FirebaseMessaging;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 720
    iput-object p2, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->subscriber:Lcom/google/firebase/events/Subscriber;

    .line 721
    return-void
.end method

.method private readEnabled()Ljava/lang/Boolean;
    .locals 6

    .line 773
    const-string v0, "firebase_messaging_auto_init_enabled"

    iget-object v1, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->this$0:Lcom/google/firebase/messaging/FirebaseMessaging;

    invoke-static {v1}, Lcom/google/firebase/messaging/FirebaseMessaging;->access$000(Lcom/google/firebase/messaging/FirebaseMessaging;)Lcom/google/firebase/FirebaseApp;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 774
    .local v1, "applicationContext":Landroid/content/Context;
    nop

    .line 775
    const-string v2, "com.google.firebase.messaging"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 778
    .local v2, "preferences":Landroid/content/SharedPreferences;
    const-string v4, "auto_init"

    invoke-interface {v2, v4}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 779
    invoke-interface {v2, v4, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 784
    :cond_0
    :try_start_0
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 785
    .local v3, "packageManager":Landroid/content/pm/PackageManager;
    if-eqz v3, :cond_1

    .line 786
    nop

    .line 788
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 787
    const/16 v5, 0x80

    invoke-virtual {v3, v4, v5}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v4

    .line 789
    .local v4, "applicationInfo":Landroid/content/pm/ApplicationInfo;
    if-eqz v4, :cond_1

    iget-object v5, v4, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    if-eqz v5, :cond_1

    iget-object v5, v4, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    .line 791
    invoke-virtual {v5, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 792
    iget-object v5, v4, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v5, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 797
    .end local v3    # "packageManager":Landroid/content/pm/PackageManager;
    .end local v4    # "applicationInfo":Landroid/content/pm/ApplicationInfo;
    :cond_1
    goto :goto_0

    .line 795
    :catch_0
    move-exception v0

    .line 800
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method declared-synchronized initialize()V
    .locals 3

    monitor-enter p0

    .line 724
    :try_start_0
    iget-boolean v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->initialized:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 725
    monitor-exit p0

    return-void

    .line 727
    :cond_0
    :try_start_1
    invoke-direct {p0}, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->readEnabled()Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->autoInitEnabled:Ljava/lang/Boolean;

    .line 728
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->autoInitEnabled:Ljava/lang/Boolean;

    if-nez v0, :cond_1

    .line 732
    new-instance v0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit$$ExternalSyntheticLambda0;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;)V

    iput-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->dataCollectionDefaultChangeEventHandler:Lcom/google/firebase/events/EventHandler;

    .line 738
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->subscriber:Lcom/google/firebase/events/Subscriber;

    const-class v1, Lcom/google/firebase/DataCollectionDefaultChange;

    iget-object v2, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->dataCollectionDefaultChangeEventHandler:Lcom/google/firebase/events/EventHandler;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/events/Subscriber;->subscribe(Ljava/lang/Class;Lcom/google/firebase/events/EventHandler;)V

    .line 741
    .end local p0    # "this":Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->initialized:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 742
    monitor-exit p0

    return-void

    .line 723
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method declared-synchronized isEnabled()Z
    .locals 1

    monitor-enter p0

    .line 745
    :try_start_0
    invoke-virtual {p0}, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->initialize()V

    .line 746
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->autoInitEnabled:Ljava/lang/Boolean;

    if-eqz v0, :cond_0

    .line 747
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->autoInitEnabled:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    goto :goto_0

    .line 748
    .end local p0    # "this":Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->this$0:Lcom/google/firebase/messaging/FirebaseMessaging;

    invoke-static {v0}, Lcom/google/firebase/messaging/FirebaseMessaging;->access$000(Lcom/google/firebase/messaging/FirebaseMessaging;)Lcom/google/firebase/FirebaseApp;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->isDataCollectionDefaultEnabled()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 746
    :goto_0
    monitor-exit p0

    return v0

    .line 744
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method synthetic lambda$initialize$0$com-google-firebase-messaging-FirebaseMessaging$AutoInit(Lcom/google/firebase/events/Event;)V
    .locals 1
    .param p1, "event"    # Lcom/google/firebase/events/Event;

    .line 734
    invoke-virtual {p0}, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 735
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->this$0:Lcom/google/firebase/messaging/FirebaseMessaging;

    invoke-static {v0}, Lcom/google/firebase/messaging/FirebaseMessaging;->access$100(Lcom/google/firebase/messaging/FirebaseMessaging;)V

    .line 737
    :cond_0
    return-void
.end method

.method declared-synchronized setEnabled(Z)V
    .locals 3
    .param p1, "enable"    # Z

    monitor-enter p0

    .line 752
    :try_start_0
    invoke-virtual {p0}, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->initialize()V

    .line 753
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->dataCollectionDefaultChangeEventHandler:Lcom/google/firebase/events/EventHandler;

    if-eqz v0, :cond_0

    .line 754
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->subscriber:Lcom/google/firebase/events/Subscriber;

    const-class v1, Lcom/google/firebase/DataCollectionDefaultChange;

    iget-object v2, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->dataCollectionDefaultChangeEventHandler:Lcom/google/firebase/events/EventHandler;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/events/Subscriber;->unsubscribe(Ljava/lang/Class;Lcom/google/firebase/events/EventHandler;)V

    .line 756
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->dataCollectionDefaultChangeEventHandler:Lcom/google/firebase/events/EventHandler;

    .line 758
    .end local p0    # "this":Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->this$0:Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 759
    invoke-static {v0}, Lcom/google/firebase/messaging/FirebaseMessaging;->access$000(Lcom/google/firebase/messaging/FirebaseMessaging;)Lcom/google/firebase/FirebaseApp;

    move-result-object v0

    .line 760
    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "com.google.firebase.messaging"

    .line 761
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 762
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 763
    .local v0, "preferencesEditor":Landroid/content/SharedPreferences$Editor;
    const-string v1, "auto_init"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 764
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 765
    if-eqz p1, :cond_1

    .line 766
    iget-object v1, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->this$0:Lcom/google/firebase/messaging/FirebaseMessaging;

    invoke-static {v1}, Lcom/google/firebase/messaging/FirebaseMessaging;->access$100(Lcom/google/firebase/messaging/FirebaseMessaging;)V

    .line 768
    :cond_1
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iput-object v1, p0, Lcom/google/firebase/messaging/FirebaseMessaging$AutoInit;->autoInitEnabled:Ljava/lang/Boolean;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 769
    monitor-exit p0

    return-void

    .line 751
    .end local v0    # "preferencesEditor":Landroid/content/SharedPreferences$Editor;
    .end local p1    # "enable":Z
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method
