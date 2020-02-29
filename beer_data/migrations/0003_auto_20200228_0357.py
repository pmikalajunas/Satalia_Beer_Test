# Generated by Django 3.0.3 on 2020-02-28 03:57

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('beer_data', '0002_auto_20200228_0356'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='beer',
            name='brewery_id',
        ),
        migrations.AddField(
            model_name='beer',
            name='brewery',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, to='beer_data.Brewery'),
            preserve_default=False,
        ),
    ]