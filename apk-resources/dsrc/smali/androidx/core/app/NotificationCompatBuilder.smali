.class Landroidx/core/app/NotificationCompatBuilder;
.super Ljava/lang/Object;
.source "NotificationCompatBuilder.java"

# interfaces
.implements Landroidx/core/app/NotificationBuilderWithBuilderAccessor;


# instance fields
.field private final mActionExtrasList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/os/Bundle;",
            ">;"
        }
    .end annotation
.end field

.field private mBigContentView:Landroid/widget/RemoteViews;

.field private final mBuilder:Landroid/app/Notification$Builder;

.field private final mBuilderCompat:Landroidx/core/app/NotificationCompat$Builder;

.field private mContentView:Landroid/widget/RemoteViews;

.field private final mExtras:Landroid/os/Bundle;

.field private mGroupAlertBehavior:I

.field private mHeadsUpContentView:Landroid/widget/RemoteViews;


# direct methods
.method constructor <init>(Landroidx/core/app/NotificationCompat$Builder;)V
    .locals 8
    .param p1, "b"    # Landroidx/core/app/NotificationCompat$Builder;

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/core/app/NotificationCompatBuilder;->mActionExtrasList:Ljava/util/List;

    .line 57
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    iput-object v0, p0, Landroidx/core/app/NotificationCompatBuilder;->mExtras:Landroid/os/Bundle;

    .line 64
    iput-object p1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilderCompat:Landroidx/core/app/NotificationCompat$Builder;

    .line 65
    nop

    .line 66
    new-instance v0, Landroid/app/Notification$Builder;

    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mChannelId:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v0, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    .line 70
    iget-object v0, p1, Landroidx/core/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    .line 71
    .local v0, "n":Landroid/app/Notification;
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-wide v2, v0, Landroid/app/Notification;->when:J

    invoke-virtual {v1, v2, v3}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, v0, Landroid/app/Notification;->icon:I

    iget v3, v0, Landroid/app/Notification;->iconLevel:I

    .line 72
    invoke-virtual {v1, v2, v3}, Landroid/app/Notification$Builder;->setSmallIcon(II)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, v0, Landroid/app/Notification;->contentView:Landroid/widget/RemoteViews;

    .line 73
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContent(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, v0, Landroid/app/Notification;->tickerText:Ljava/lang/CharSequence;

    iget-object v3, p1, Landroidx/core/app/NotificationCompat$Builder;->mTickerView:Landroid/widget/RemoteViews;

    .line 74
    invoke-virtual {v1, v2, v3}, Landroid/app/Notification$Builder;->setTicker(Ljava/lang/CharSequence;Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, v0, Landroid/app/Notification;->vibrate:[J

    .line 75
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setVibrate([J)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, v0, Landroid/app/Notification;->ledARGB:I

    iget v3, v0, Landroid/app/Notification;->ledOnMS:I

    iget v4, v0, Landroid/app/Notification;->ledOffMS:I

    .line 76
    invoke-virtual {v1, v2, v3, v4}, Landroid/app/Notification$Builder;->setLights(III)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, v0, Landroid/app/Notification;->flags:I

    and-int/lit8 v2, v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    move v2, v4

    .line 77
    :goto_0
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, v0, Landroid/app/Notification;->flags:I

    and-int/lit8 v2, v2, 0x8

    if-eqz v2, :cond_1

    move v2, v3

    goto :goto_1

    :cond_1
    move v2, v4

    .line 78
    :goto_1
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setOnlyAlertOnce(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, v0, Landroid/app/Notification;->flags:I

    and-int/lit8 v2, v2, 0x10

    if-eqz v2, :cond_2

    move v2, v3

    goto :goto_2

    :cond_2
    move v2, v4

    .line 79
    :goto_2
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, v0, Landroid/app/Notification;->defaults:I

    .line 80
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setDefaults(I)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentTitle:Ljava/lang/CharSequence;

    .line 81
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentText:Ljava/lang/CharSequence;

    .line 82
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentInfo:Ljava/lang/CharSequence;

    .line 83
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentInfo(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentIntent:Landroid/app/PendingIntent;

    .line 84
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, v0, Landroid/app/Notification;->deleteIntent:Landroid/app/PendingIntent;

    .line 85
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setDeleteIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mFullScreenIntent:Landroid/app/PendingIntent;

    iget v5, v0, Landroid/app/Notification;->flags:I

    and-int/lit16 v5, v5, 0x80

    if-eqz v5, :cond_3

    goto :goto_3

    :cond_3
    move v3, v4

    .line 86
    :goto_3
    invoke-virtual {v1, v2, v3}, Landroid/app/Notification$Builder;->setFullScreenIntent(Landroid/app/PendingIntent;Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mLargeIcon:Landroid/graphics/Bitmap;

    .line 88
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mNumber:I

    .line 89
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setNumber(I)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mProgressMax:I

    iget v3, p1, Landroidx/core/app/NotificationCompat$Builder;->mProgress:I

    iget-boolean v5, p1, Landroidx/core/app/NotificationCompat$Builder;->mProgressIndeterminate:Z

    .line 90
    invoke-virtual {v1, v2, v3, v5}, Landroid/app/Notification$Builder;->setProgress(IIZ)Landroid/app/Notification$Builder;

    .line 91
    nop

    .line 94
    nop

    .line 95
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mSubText:Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setSubText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-boolean v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mUseChronometer:Z

    .line 96
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mPriority:I

    .line 97
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    .line 99
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mActions:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/core/app/NotificationCompat$Action;

    .line 100
    .local v2, "action":Landroidx/core/app/NotificationCompat$Action;
    invoke-direct {p0, v2}, Landroidx/core/app/NotificationCompatBuilder;->addAction(Landroidx/core/app/NotificationCompat$Action;)V

    .line 101
    .end local v2    # "action":Landroidx/core/app/NotificationCompat$Action;
    goto :goto_4

    .line 103
    :cond_4
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mExtras:Landroid/os/Bundle;

    if-eqz v1, :cond_5

    .line 104
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mExtras:Landroid/os/Bundle;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mExtras:Landroid/os/Bundle;

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    .line 106
    :cond_5
    nop

    .line 124
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentView:Landroid/widget/RemoteViews;

    iput-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mContentView:Landroid/widget/RemoteViews;

    .line 125
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mBigContentView:Landroid/widget/RemoteViews;

    iput-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBigContentView:Landroid/widget/RemoteViews;

    .line 127
    nop

    .line 128
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-boolean v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mShowWhen:Z

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    .line 130
    nop

    .line 137
    nop

    .line 138
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-boolean v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mLocalOnly:Z

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setLocalOnly(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mGroupKey:Ljava/lang/String;

    .line 139
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-boolean v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mGroupSummary:Z

    .line 140
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setGroupSummary(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mSortKey:Ljava/lang/String;

    .line 141
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setSortKey(Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 143
    iget v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mGroupAlertBehavior:I

    iput v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mGroupAlertBehavior:I

    .line 145
    nop

    .line 146
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mCategory:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mColor:I

    .line 147
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setColor(I)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mVisibility:I

    .line 148
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mPublicVersion:Landroid/app/Notification;

    .line 149
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setPublicVersion(Landroid/app/Notification;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, v0, Landroid/app/Notification;->sound:Landroid/net/Uri;

    iget-object v3, v0, Landroid/app/Notification;->audioAttributes:Landroid/media/AudioAttributes;

    .line 150
    invoke-virtual {v1, v2, v3}, Landroid/app/Notification$Builder;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)Landroid/app/Notification$Builder;

    .line 152
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mPeople:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_5
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 153
    .local v2, "person":Ljava/lang/String;
    iget-object v3, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    invoke-virtual {v3, v2}, Landroid/app/Notification$Builder;->addPerson(Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 154
    .end local v2    # "person":Ljava/lang/String;
    goto :goto_5

    .line 155
    :cond_6
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mHeadsUpContentView:Landroid/widget/RemoteViews;

    iput-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mHeadsUpContentView:Landroid/widget/RemoteViews;

    .line 157
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mInvisibleActions:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_9

    .line 160
    nop

    .line 161
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "android.car.EXTENSIONS"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v1

    .line 162
    .local v1, "carExtenderBundle":Landroid/os/Bundle;
    if-nez v1, :cond_7

    .line 163
    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    move-object v1, v3

    .line 165
    :cond_7
    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    .line 166
    .local v3, "listBundle":Landroid/os/Bundle;
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_6
    iget-object v6, p1, Landroidx/core/app/NotificationCompat$Builder;->mInvisibleActions:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v5, v6, :cond_8

    .line 167
    nop

    .line 168
    invoke-static {v5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v6

    iget-object v7, p1, Landroidx/core/app/NotificationCompat$Builder;->mInvisibleActions:Ljava/util/ArrayList;

    .line 170
    invoke-virtual {v7, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroidx/core/app/NotificationCompat$Action;

    .line 169
    invoke-static {v7}, Landroidx/core/app/NotificationCompatJellybean;->getBundleForAction(Landroidx/core/app/NotificationCompat$Action;)Landroid/os/Bundle;

    move-result-object v7

    .line 167
    invoke-virtual {v3, v6, v7}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 166
    add-int/lit8 v5, v5, 0x1

    goto :goto_6

    .line 172
    .end local v5    # "i":I
    :cond_8
    const-string v5, "invisible_actions"

    invoke-virtual {v1, v5, v3}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 174
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v5

    invoke-virtual {v5, v2, v1}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 176
    iget-object v5, p0, Landroidx/core/app/NotificationCompatBuilder;->mExtras:Landroid/os/Bundle;

    invoke-virtual {v5, v2, v1}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 180
    .end local v1    # "carExtenderBundle":Landroid/os/Bundle;
    .end local v3    # "listBundle":Landroid/os/Bundle;
    :cond_9
    nop

    .line 181
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mExtras:Landroid/os/Bundle;

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setExtras(Landroid/os/Bundle;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mRemoteInputHistory:[Ljava/lang/CharSequence;

    .line 182
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setRemoteInputHistory([Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    .line 183
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentView:Landroid/widget/RemoteViews;

    if-eqz v1, :cond_a

    .line 184
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mContentView:Landroid/widget/RemoteViews;

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setCustomContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    .line 186
    :cond_a
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mBigContentView:Landroid/widget/RemoteViews;

    if-eqz v1, :cond_b

    .line 187
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mBigContentView:Landroid/widget/RemoteViews;

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setCustomBigContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    .line 189
    :cond_b
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mHeadsUpContentView:Landroid/widget/RemoteViews;

    if-eqz v1, :cond_c

    .line 190
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mHeadsUpContentView:Landroid/widget/RemoteViews;

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setCustomHeadsUpContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    .line 193
    :cond_c
    nop

    .line 194
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mBadgeIcon:I

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setBadgeIconType(I)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mShortcutId:Ljava/lang/String;

    .line 195
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setShortcutId(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-wide v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mTimeout:J

    .line 196
    invoke-virtual {v1, v2, v3}, Landroid/app/Notification$Builder;->setTimeoutAfter(J)Landroid/app/Notification$Builder;

    move-result-object v1

    iget v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mGroupAlertBehavior:I

    .line 197
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setGroupAlertBehavior(I)Landroid/app/Notification$Builder;

    .line 198
    iget-boolean v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mColorizedSet:Z

    if-eqz v1, :cond_d

    .line 199
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-boolean v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mColorized:Z

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setColorized(Z)Landroid/app/Notification$Builder;

    .line 202
    :cond_d
    iget-object v1, p1, Landroidx/core/app/NotificationCompat$Builder;->mChannelId:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_e

    .line 203
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setSound(Landroid/net/Uri;)Landroid/app/Notification$Builder;

    move-result-object v1

    .line 204
    invoke-virtual {v1, v4}, Landroid/app/Notification$Builder;->setDefaults(I)Landroid/app/Notification$Builder;

    move-result-object v1

    .line 205
    invoke-virtual {v1, v4, v4, v4}, Landroid/app/Notification$Builder;->setLights(III)Landroid/app/Notification$Builder;

    move-result-object v1

    .line 206
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setVibrate([J)Landroid/app/Notification$Builder;

    .line 209
    :cond_e
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_f

    .line 210
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-boolean v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mAllowSystemGeneratedContextualActions:Z

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setAllowSystemGeneratedContextualActions(Z)Landroid/app/Notification$Builder;

    .line 213
    iget-object v1, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    iget-object v2, p1, Landroidx/core/app/NotificationCompat$Builder;->mBubbleMetadata:Landroidx/core/app/NotificationCompat$BubbleMetadata;

    .line 214
    invoke-static {v2}, Landroidx/core/app/NotificationCompat$BubbleMetadata;->toPlatform(Landroidx/core/app/NotificationCompat$BubbleMetadata;)Landroid/app/Notification$BubbleMetadata;

    move-result-object v2

    .line 213
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setBubbleMetadata(Landroid/app/Notification$BubbleMetadata;)Landroid/app/Notification$Builder;

    .line 216
    :cond_f
    return-void
.end method

.method private addAction(Landroidx/core/app/NotificationCompat$Action;)V
    .locals 5
    .param p1, "action"    # Landroidx/core/app/NotificationCompat$Action;

    .line 263
    nop

    .line 265
    nop

    .line 266
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getIconCompat()Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v0

    .line 267
    .local v0, "iconCompat":Landroidx/core/graphics/drawable/IconCompat;
    new-instance v1, Landroid/app/Notification$Action$Builder;

    if-nez v0, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    .line 268
    :cond_0
    invoke-virtual {v0}, Landroidx/core/graphics/drawable/IconCompat;->toIcon()Landroid/graphics/drawable/Icon;

    move-result-object v2

    :goto_0
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getTitle()Ljava/lang/CharSequence;

    move-result-object v3

    .line 269
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getActionIntent()Landroid/app/PendingIntent;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Landroid/app/Notification$Action$Builder;-><init>(Landroid/graphics/drawable/Icon;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    .line 270
    .end local v0    # "iconCompat":Landroidx/core/graphics/drawable/IconCompat;
    .local v1, "actionBuilder":Landroid/app/Notification$Action$Builder;
    nop

    .line 274
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 275
    nop

    .line 276
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getRemoteInputs()[Landroidx/core/app/RemoteInput;

    move-result-object v0

    .line 275
    invoke-static {v0}, Landroidx/core/app/RemoteInput;->fromCompat([Landroidx/core/app/RemoteInput;)[Landroid/app/RemoteInput;

    move-result-object v0

    array-length v2, v0

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v2, :cond_1

    aget-object v4, v0, v3

    .line 277
    .local v4, "remoteInput":Landroid/app/RemoteInput;
    invoke-virtual {v1, v4}, Landroid/app/Notification$Action$Builder;->addRemoteInput(Landroid/app/RemoteInput;)Landroid/app/Notification$Action$Builder;

    .line 275
    .end local v4    # "remoteInput":Landroid/app/RemoteInput;
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 281
    :cond_1
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 282
    new-instance v0, Landroid/os/Bundle;

    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/os/Bundle;-><init>(Landroid/os/Bundle;)V

    .local v0, "actionExtras":Landroid/os/Bundle;
    goto :goto_2

    .line 284
    .end local v0    # "actionExtras":Landroid/os/Bundle;
    :cond_2
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 286
    .restart local v0    # "actionExtras":Landroid/os/Bundle;
    :goto_2
    nop

    .line 287
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getAllowGeneratedReplies()Z

    move-result v2

    .line 286
    const-string v3, "android.support.allowGeneratedReplies"

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 288
    nop

    .line 289
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getAllowGeneratedReplies()Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/app/Notification$Action$Builder;->setAllowGeneratedReplies(Z)Landroid/app/Notification$Action$Builder;

    .line 292
    nop

    .line 293
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getSemanticAction()I

    move-result v2

    .line 292
    const-string v3, "android.support.action.semanticAction"

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 294
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1c

    if-lt v2, v3, :cond_3

    .line 295
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getSemanticAction()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/app/Notification$Action$Builder;->setSemanticAction(I)Landroid/app/Notification$Action$Builder;

    .line 298
    :cond_3
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    if-lt v2, v3, :cond_4

    .line 299
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->isContextual()Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/app/Notification$Action$Builder;->setContextual(Z)Landroid/app/Notification$Action$Builder;

    .line 302
    :cond_4
    nop

    .line 303
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getShowsUserInterface()Z

    move-result v2

    .line 302
    const-string v3, "android.support.action.showsUserInterface"

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 304
    invoke-virtual {v1, v0}, Landroid/app/Notification$Action$Builder;->addExtras(Landroid/os/Bundle;)Landroid/app/Notification$Action$Builder;

    .line 305
    iget-object v2, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    invoke-virtual {v1}, Landroid/app/Notification$Action$Builder;->build()Landroid/app/Notification$Action;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    .line 306
    .end local v0    # "actionExtras":Landroid/os/Bundle;
    .end local v1    # "actionBuilder":Landroid/app/Notification$Action$Builder;
    nop

    .line 310
    return-void
.end method

.method private removeSoundAndVibration(Landroid/app/Notification;)V
    .locals 1
    .param p1, "notification"    # Landroid/app/Notification;

    .line 438
    const/4 v0, 0x0

    iput-object v0, p1, Landroid/app/Notification;->sound:Landroid/net/Uri;

    .line 439
    iput-object v0, p1, Landroid/app/Notification;->vibrate:[J

    .line 440
    iget v0, p1, Landroid/app/Notification;->defaults:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p1, Landroid/app/Notification;->defaults:I

    .line 441
    iget v0, p1, Landroid/app/Notification;->defaults:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p1, Landroid/app/Notification;->defaults:I

    .line 442
    return-void
.end method


# virtual methods
.method public build()Landroid/app/Notification;
    .locals 4

    .line 224
    iget-object v0, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilderCompat:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroidx/core/app/NotificationCompat$Builder;->mStyle:Landroidx/core/app/NotificationCompat$Style;

    .line 225
    .local v0, "style":Landroidx/core/app/NotificationCompat$Style;
    if-eqz v0, :cond_0

    .line 226
    invoke-virtual {v0, p0}, Landroidx/core/app/NotificationCompat$Style;->apply(Landroidx/core/app/NotificationBuilderWithBuilderAccessor;)V

    .line 229
    :cond_0
    if-eqz v0, :cond_1

    .line 230
    invoke-virtual {v0, p0}, Landroidx/core/app/NotificationCompat$Style;->makeContentView(Landroidx/core/app/NotificationBuilderWithBuilderAccessor;)Landroid/widget/RemoteViews;

    move-result-object v1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    .line 232
    .local v1, "styleContentView":Landroid/widget/RemoteViews;
    :goto_0
    invoke-virtual {p0}, Landroidx/core/app/NotificationCompatBuilder;->buildInternal()Landroid/app/Notification;

    move-result-object v2

    .line 233
    .local v2, "n":Landroid/app/Notification;
    if-eqz v1, :cond_2

    .line 234
    iput-object v1, v2, Landroid/app/Notification;->contentView:Landroid/widget/RemoteViews;

    goto :goto_1

    .line 235
    :cond_2
    iget-object v3, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilderCompat:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroidx/core/app/NotificationCompat$Builder;->mContentView:Landroid/widget/RemoteViews;

    if-eqz v3, :cond_3

    .line 236
    iget-object v3, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilderCompat:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroidx/core/app/NotificationCompat$Builder;->mContentView:Landroid/widget/RemoteViews;

    iput-object v3, v2, Landroid/app/Notification;->contentView:Landroid/widget/RemoteViews;

    .line 238
    :cond_3
    :goto_1
    if-eqz v0, :cond_4

    .line 239
    invoke-virtual {v0, p0}, Landroidx/core/app/NotificationCompat$Style;->makeBigContentView(Landroidx/core/app/NotificationBuilderWithBuilderAccessor;)Landroid/widget/RemoteViews;

    move-result-object v3

    .line 240
    .local v3, "styleBigContentView":Landroid/widget/RemoteViews;
    if-eqz v3, :cond_4

    .line 241
    iput-object v3, v2, Landroid/app/Notification;->bigContentView:Landroid/widget/RemoteViews;

    .line 244
    .end local v3    # "styleBigContentView":Landroid/widget/RemoteViews;
    :cond_4
    if-eqz v0, :cond_5

    .line 245
    iget-object v3, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilderCompat:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroidx/core/app/NotificationCompat$Builder;->mStyle:Landroidx/core/app/NotificationCompat$Style;

    .line 246
    invoke-virtual {v3, p0}, Landroidx/core/app/NotificationCompat$Style;->makeHeadsUpContentView(Landroidx/core/app/NotificationBuilderWithBuilderAccessor;)Landroid/widget/RemoteViews;

    move-result-object v3

    .line 247
    .local v3, "styleHeadsUpContentView":Landroid/widget/RemoteViews;
    if-eqz v3, :cond_5

    .line 248
    iput-object v3, v2, Landroid/app/Notification;->headsUpContentView:Landroid/widget/RemoteViews;

    .line 252
    .end local v3    # "styleHeadsUpContentView":Landroid/widget/RemoteViews;
    :cond_5
    if-eqz v0, :cond_6

    .line 253
    invoke-static {v2}, Landroidx/core/app/NotificationCompat;->getExtras(Landroid/app/Notification;)Landroid/os/Bundle;

    move-result-object v3

    .line 254
    .local v3, "extras":Landroid/os/Bundle;
    if-eqz v3, :cond_6

    .line 255
    invoke-virtual {v0, v3}, Landroidx/core/app/NotificationCompat$Style;->addCompatExtras(Landroid/os/Bundle;)V

    .line 259
    .end local v3    # "extras":Landroid/os/Bundle;
    :cond_6
    return-object v2
.end method

.method protected buildInternal()Landroid/app/Notification;
    .locals 1

    .line 314
    nop

    .line 315
    iget-object v0, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method public getBuilder()Landroid/app/Notification$Builder;
    .locals 1

    .line 220
    iget-object v0, p0, Landroidx/core/app/NotificationCompatBuilder;->mBuilder:Landroid/app/Notification$Builder;

    return-object v0
.end method
