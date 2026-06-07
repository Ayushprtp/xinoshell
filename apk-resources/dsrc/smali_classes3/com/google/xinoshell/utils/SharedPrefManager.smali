.class public Lcom/google/xinoshell/utils/SharedPrefManager;
.super Ljava/lang/Object;
.source "SharedPrefManager.java"


# static fields
.field private static final PREF_NAME:Ljava/lang/String; = "EarnMoney"

.field private static instance:Lcom/google/xinoshell/utils/SharedPrefManager;


# instance fields
.field private final editor:Landroid/content/SharedPreferences$Editor;

.field private final sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    const-string v0, "EarnMoney"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 16
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    .line 17
    return-void
.end method


# virtual methods
.method public clear()V
    .locals 1

    .line 71
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    .line 72
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 73
    return-void
.end method

.method public get(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .line 26
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getB(Ljava/lang/String;)Z
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .line 36
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public getFloat(Ljava/lang/String;)F
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .line 56
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v0

    return v0
.end method

.method public getInt(Ljava/lang/String;)I
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .line 46
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public getLong(Ljava/lang/String;)J
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .line 66
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->sharedPreferences:Landroid/content/SharedPreferences;

    const-wide/16 v1, 0x0

    invoke-interface {v0, p1, v1, v2}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method public remove(Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .line 77
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, p1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 78
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 79
    return-void
.end method

.method public set(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 21
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 22
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 23
    return-void
.end method

.method public setB(Ljava/lang/String;Z)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Z

    .line 31
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 32
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 33
    return-void
.end method

.method public setFloat(Ljava/lang/String;F)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # F

    .line 51
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    .line 52
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 53
    return-void
.end method

.method public setInt(Ljava/lang/String;I)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # I

    .line 41
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 42
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 43
    return-void
.end method

.method public setLong(Ljava/lang/String;J)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # J

    .line 61
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 62
    iget-object v0, p0, Lcom/google/xinoshell/utils/SharedPrefManager;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 63
    return-void
.end method
